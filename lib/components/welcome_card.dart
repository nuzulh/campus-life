import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: const LinearGradient(
          colors: <Color>[Colors.white38, Colors.white24],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Icon(
              FontAwesomeIcons.school,
              color: Colors.black87,
              size: 30.0,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GetX<AuthController>(
                init: AuthController(),
                builder: (controller) => FutureBuilder(
                    future:
                        controller.getUser(controller.firebaseUser.value!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Welcome, ${controller.user.value.firstName}!',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        );
                      }
                      return const Text('...');
                    }),
              ),
              Obx(
                () => Text(
                  homeController.time.value,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
