import 'package:campus_life/components/auth_textfield.dart';
import 'package:campus_life/components/bottom_label.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    controller.resetForm();

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
                        'Complete Profile',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 8.0),
                      AuthTextField(
                        controller: controller.firstNameController,
                        labelText: 'First Name',
                        hintText: 'Nuzul',
                        icon: FontAwesomeIcons.solidUser,
                      ),
                      AuthTextField(
                        controller: controller.lastNameController,
                        labelText: 'Last Name',
                        hintText: 'H',
                        icon: FontAwesomeIcons.solidUser,
                      ),
                      AuthTextField(
                        controller: controller.universityController,
                        labelText: 'University',
                        hintText: 'Syiah Kuala University',
                        icon: FontAwesomeIcons.school,
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                        () => controller.isLoading.value
                            ? LoadingAnimationWidget.horizontalRotatingDots(
                                color: Colors.black87, size: 60.0)
                            : Button(
                                text: 'Submit',
                                onPressed: controller.saveGoogleUser,
                              ),
                      ),
                    ],
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
