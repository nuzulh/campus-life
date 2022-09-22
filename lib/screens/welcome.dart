import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    RxBool isLogin = true.obs;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const PrimaryBg(isLeft: true, isBottom: true),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Campus',
                          style: Theme.of(context).textTheme.headline1),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Text('Life',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/person.png'),
              ],
            ),
          ),
          Positioned(
            top: size.height / 1.5,
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => Button(
                      text: isLogin.value
                          ? 'Login with Email'
                          : 'Register with Email',
                      icon: FontAwesomeIcons.envelope,
                      onPressed: () {
                        if (isLogin.value) {
                          Get.toNamed('/login');
                        } else {
                          Get.toNamed('/register');
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? LoadingAnimationWidget.horizontalRotatingDots(
                            color: Colors.black87,
                            size: 60.0,
                          )
                        : Button(
                            text: isLogin.value
                                ? 'Login with Google'
                                : 'Register with Google',
                            icon: FontAwesomeIcons.google,
                            color: const Color(0xFF3F8798),
                            onPressed: controller.signInWithGoogle,
                          ),
                  ),
                  const SizedBox(height: 24.0),
                  InkWell(
                    onTap: () {
                      isLogin.value = !isLogin.value;
                    },
                    child: Obx(
                      () => Text(
                        isLogin.value
                            ? "Don't have an account? Register"
                            : "Already have an account? Login",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
