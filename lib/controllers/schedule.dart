import 'dart:convert';
import 'dart:io';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduleController extends GetxController {
  static ScheduleController get to => ScheduleController();
  final AuthController authController = Get.put(AuthController());

  final Rx<DateTime> today = DateTime.now().obs;
  final LocalNotification service = LocalNotification();

  RxList subjects = [].obs;
  RxBool isSubjectEmpty = true.obs;
  RxBool isLoading = false.obs;
  RxMap allSubjects = {}.obs;

  @override
  onInit() async {
    await setScheduleNotifications();
    super.onInit();
  }

  Future<void> renderSubjects(int day) async {
    subjects.value = await getSubjects(day).then((value) async {
      isSubjectEmpty.value = await isSubjectsEmpty().then((value) {
        isLoading.value = false;
        return value;
      });
      isLoading.value = false;
      return value;
    });
  }

  Future<void> resetSchedules() async {
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .delete();
  }

  Future<void> deleteAccount() async {
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .delete();
  }

  Future<List> getSubjects(int day) async {
    isLoading.value = true;
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(day.toString())
        .collection('subjects')
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<Map> getAllSubjects() async {
    isLoading.value = true;
    Map results = {};
    for (int i = 0; i < 7; i++) {
      results[i] = await authController.db
          .collection('users')
          .doc(authController.firebaseUser.value?.uid)
          .collection('schedule')
          .doc(i.toString())
          .collection('subjects')
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    }
    allSubjects.value = results;
    isLoading.value = false;
    return results;
  }

  Future<void> getSimkuliahSchedule(String npm, String password) async {
    if (npm.isNotEmpty && password.isNotEmpty) {
      Uri simkuliahUri = Uri.https(
          'be-simkuliah-usk.netlify.app', '/.netlify/functions/get-jadwal');
      isLoading.value = true;
      try {
        await post(
          simkuliahUri,
          body: jsonEncode({
            'npm': npm,
            'password': password,
          }),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ).then((response) {
          isLoading.value = false;
          final result = jsonDecode(response.body);
          if (result['result']['success']) {
            Get.defaultDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
              titlePadding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
              title: 'Confirm your schedules',
              titleStyle: GoogleFonts.poppins(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: Get.height / 1.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${result['result']['name']}",
                      style: GoogleFonts.poppins(fontSize: 13.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        "NPM: ${result['npm']}",
                        style: GoogleFonts.poppins(fontSize: 13.0),
                      ),
                    ),
                    Text(
                      'Monday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['mon'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['mon'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['mon'][index]['jam']} - ${result['result']['mon'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                    Text(
                      'Tuesday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['tue'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['tue'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['tue'][index]['jam']} - ${result['result']['tue'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                    Text(
                      'Wednesday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['wed'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['wed'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['wed'][index]['jam']} - ${result['result']['wed'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                    Text(
                      'Thursday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['thu'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['thu'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['thu'][index]['jam']} - ${result['result']['thu'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                    Text(
                      'Friday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['fri'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['fri'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['fri'][index]['jam']} - ${result['result']['fri'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                    Text(
                      'Saturday',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    result['result']['sat'].length > 0
                        ? Flexible(
                            child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: result['result']['sat'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${result['result']['sat'][index]['jam']} - ${result['result']['sat'][index]['mk']}",
                                style: GoogleFonts.poppins(fontSize: 12.0),
                              );
                            },
                          ))
                        : const Text('-'),
                  ],
                ),
              ),
              confirm: Obx(
                () => isLoading.value
                    ? LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.black87, size: 60.0)
                    : Button(
                        text: 'Save schedules',
                        icon: Icons.save_alt,
                        onPressed: () async {
                          await saveSimkuliahSchedule(result['result'])
                              .then((_) {
                            Get.offAllNamed('/home');
                          });
                        },
                      ),
              ),
            );
          } else {
            Get.snackbar(
              'Error',
              'NPM or Password is incorrect.',
              margin: const EdgeInsets.all(8.0),
              duration: const Duration(seconds: 2),
            );
          }
        });
      } catch (e) {
        Get.snackbar(
          'Error',
          'SIMKULIAH internal server error. Please try again later.',
          margin: const EdgeInsets.all(8.0),
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'NPM and Password cannot be empty.',
        margin: const EdgeInsets.all(8.0),
        duration: const Duration(seconds: 2),
      );
    }
    isLoading.value = false;
  }

  Future<bool> isSubjectsEmpty() async {
    final check = await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .get();
    return check.docs.isEmpty;
  }

  Future<void> saveSimkuliahSchedule(Map schedule) async {
    final List days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
    isLoading.value = true;
    for (String day in days) {
      await authController.db
          .collection('users')
          .doc(authController.firebaseUser.value?.uid)
          .collection('schedule')
          .doc(days.indexOf(day).toString())
          .set({'day': day}).then(
        (_) async {
          for (Map<String, dynamic> subject in schedule[day]) {
            await authController.db
                .collection('users')
                .doc(authController.firebaseUser.value?.uid)
                .collection('schedule')
                .doc(days.indexOf(day).toString())
                .collection('subjects')
                .add(
              {
                'name': subject['mk'],
                'time': subject['jam'],
              },
            );
          }
        },
      );
    }
    isLoading.value = false;
  }

  Future setScheduleNotifications() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    for (int i = 0; i < 6; i++) {
      await getSubjects(i).then((value) async {
        if (value.isNotEmpty) {
          for (Map val in value) {
            int hour = int.parse(val['time'].split(':')[0]);
            int minute = int.parse(val['time'].split(':')[1]);
            tz.TZDateTime notificationTime = tz.TZDateTime(
                    tz.local, now.year, now.month, now.day, hour, minute)
                .subtract(Duration(days: now.weekday - 1, minutes: 15))
                .add(Duration(days: DateTime.daysPerWeek + i));
            await service.showWeeklyNotification(
                id: i + hour,
                title: val["name"],
                body: '15 minutes before class starts',
                notificationTime:
                    notificationTime.add(const Duration(days: 2)));
          }
        }
      });
    }
  }
}
