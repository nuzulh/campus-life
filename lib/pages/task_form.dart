import 'package:campus_life/components/auth_textfield.dart';
import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    TextEditingController subjectController = TextEditingController();

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AuthTextField(
                        controller: subjectController,
                        labelText: 'Select subject',
                        hintText: 'Subject',
                        icon: FontAwesomeIcons.bookOpenReader,
                      ),
                      AuthTextField(
                          controller: subjectController,
                          labelText: 'Deadline',
                          hintText: '12/12/2022 59:00',
                          icon: FontAwesomeIcons.calendarMinus),
                      AuthTextField(
                          controller: subjectController,
                          labelText: 'Detail',
                          hintText: 'Your task details',
                          maxLines: 5,
                          icon: FontAwesomeIcons.noteSticky),
                      Button(text: 'Submit', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => MyBackButton(
                label:
                    "${homeController.days[homeController.selectedDay.value]}'s task"),
          ),
        ],
      ),
    );
  }
}
