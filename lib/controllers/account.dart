import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/models/user.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  static AccountController get to => AccountController();
  final AuthController authController = Get.put(AuthController());
  Rx<UserModel> user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    university: '',
  ).obs;

  @override
  void onInit() async {
    user.value =
        await authController.getUser(authController.firebaseUser.value!.uid);
    super.onInit();
  }
}
