import 'package:campus_life/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  GoogleSignIn googleSign = GoogleSignIn();
  Rx<UserModel> user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    university: '',
  ).obs;

  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  late RxBool isLoading = false.obs;
  late RxString errorMessage = ''.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    ever(errorMessage, showSnackBar);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialPage);
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, setInitialScreenGoogle);
  }

  setInitialPage(User? tempUser) async {
    if (tempUser == null) {
      Get.offAllNamed('/welcome');
    } else {
      user.value = await getUser(firebaseUser.value!.uid);
      if (user.value.firstName == '') {
        Get.offAllNamed('/complete-profile');
      } else {
        Get.offAllNamed('/page-tree');
      }
    }
  }

  setInitialScreenGoogle(GoogleSignInAccount? tempUser) async {
    if (tempUser == null) {
      Get.offAllNamed('/welcome');
    } else {
      user.value = await getUser(firebaseUser.value!.uid);
      if (user.value.firstName == '') {
        Get.offAllNamed('/complete-profile');
      } else {
        Get.offAllNamed('/page-tree');
      }
    }
  }

  showSnackBar(String message) {
    if (errorMessage.value != '') {
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
    errorMessage.value = '';
  }

  void resetForm() {
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    universityController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
  }

  Future<void> saveUser() async {
    try {
      await db.collection('users').doc(firebaseUser.value?.uid).set(UserModel(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            university: universityController.text.trim(),
          ).toMap());
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> saveGoogleUser() async {
    try {
      isLoading.value = true;
      await db
          .collection('users')
          .doc(firebaseUser.value?.uid)
          .set(UserModel(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: firebaseUser.value?.email ?? '',
            university: universityController.text.trim(),
          ).toMap())
          .then((_) => setInitialScreenGoogle(googleSignInAccount.value));
      resetForm();
    } catch (e) {
      errorMessage.value = e.toString();
    }
    isLoading.value = false;
  }

  Future<UserModel> getUser(String uid) async {
    UserModel userModel = UserModel.fromDocumentSnapshot(
        await db.collection('users').doc(firebaseUser.value?.uid).get());
    if (userModel.firstName == '') {
      userModel = UserModel.fromDocumentSnapshot(await db
          .collection('users')
          .doc(googleSignInAccount.value?.id)
          .get());
    }
    return userModel;
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
    isLoading.value = false;
  }

  Future<void> register() async {
    try {
      if (passwordController.text == rePasswordController.text) {
        isLoading.value = true;
        await auth
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((_) {
          saveUser();
        });
        resetForm();
      } else {
        errorMessage.value = "Password Doesn't match";
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? '';
    }
    isLoading.value = false;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      resetForm();
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? '';
    }
    isLoading.value = false;
  }

  Future<void> signOut() async {
    googleSign.signOut();
    await auth.signOut();
  }
}
