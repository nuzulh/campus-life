import 'package:campus_life/components/auth_textfield.dart';
import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/bottom_label.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const PrimaryBg(isLeft: false, isBottom: false),
                  const BottomLabel(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 8.0),
                      AuthTextField(
                        controller: controller.emailController,
                        labelText: 'Email',
                        hintText: 'nuzul@example.com',
                        icon: FontAwesomeIcons.solidEnvelope,
                      ),
                      AuthTextField(
                        controller: controller.passwordController,
                        isPassword: true,
                        labelText: 'Password',
                        hintText: '********',
                        icon: FontAwesomeIcons.key,
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                        () => controller.isLoading.value
                            ? LoadingAnimationWidget.horizontalRotatingDots(
                                color: Colors.black87,
                                size: 60.0,
                              )
                            : Button(
                                text: 'Login',
                                onPressed: controller.login,
                              ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Reset password',
                              style: TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const MyBackButton(),
        ],
      ),
    );
  }
}
