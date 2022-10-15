import 'package:campus_life/components/auth_textfield.dart';
import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SimkuliahForm extends StatelessWidget {
  const SimkuliahForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController npmController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    RxBool isLoading = false.obs;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const PrimaryBg(isLeft: true, isBottom: false),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/usk.png',
                        width: Get.width / 3.6,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'SIMKULIAH',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      AuthTextField(
                        controller: npmController,
                        labelText: 'NPM',
                        hintText: '19041110xxxxx',
                        icon: FontAwesomeIcons.idCard,
                      ),
                      AuthTextField(
                        controller: passwordController,
                        isPassword: true,
                        labelText: 'Password',
                        hintText: '********',
                        icon: FontAwesomeIcons.key,
                      ),
                      Obx(
                        () => isLoading.value
                            ? LoadingAnimationWidget.horizontalRotatingDots(
                                color: Colors.black87, size: 60.0)
                            : Button(
                                text: 'Get schedules',
                                onPressed: () async {
                                  isLoading.value = true;
                                  await ScheduleController.to
                                      .getSimkuliahSchedule(
                                    npmController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  isLoading.value = false;
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const MyBackButton(label: ''),
        ],
      ),
    );
  }
}
