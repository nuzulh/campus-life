import 'package:campus_life/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final Rx<User?> user = controller.firebaseUser;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(user.value!.email.toString()),
          ElevatedButton(
            onPressed: controller.signOut,
            child: const Text('sign out'),
          ),
        ],
      ),
    );
  }
}