import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  const PrimaryBg(isLeft: false, isBottom: false),
                  Center(
                    child: Button(
                      text: 'Reset Schedules',
                      onPressed: () {
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(0.0),
                          title: '',
                          titleStyle: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                          content: const Text(
                              'Are you sure to delete all schedules (including tasks)?'),
                          confirm: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CupertinoButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              SizedBox(
                                width: Get.width / 2.5,
                                child: Button(
                                  text: 'Confirm',
                                  color: Colors.red,
                                  onPressed: () async {
                                    await ScheduleController.to
                                        .resetSchedules();
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
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
