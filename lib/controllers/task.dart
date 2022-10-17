import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_life/services/local_notification.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskController extends GetxController {
  static TaskController get to => TaskController();
  final AuthController authController = Get.put(AuthController());
  final ScheduleController scheduleController = Get.put(ScheduleController());
  final LocalNotification service = LocalNotification();

  final List days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
  RxBool isLoading = false.obs;
  Rx<TextEditingController> deadlineController = TextEditingController().obs;
  Rx<TextEditingController> detailController = TextEditingController().obs;
  RxString dropdownValue = ''.obs;
  RxString subjectId = ''.obs;
  RxList tasks = [].obs;
  RxList todayTasks = [].obs;

  @override
  void onInit() {
    isLoading.value = true;
    deadlineController.value.text = DateTime.now().toString().split('.')[0];
    dropdownValue.value = scheduleController.subjects[0]['name'];
    super.onInit();
  }

  Future<void> renderTasks(String subjectName) async {
    subjectId.value = await getSubjectId(subjectName);
    tasks.value = await getTasks(subjectId.value);
    isLoading.value = false;
  }

  Future<String> getSubjectId(String subjectName) async {
    List result = await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .where('name', isEqualTo: subjectName)
        .get()
        .then((value) => value.docs.map((e) => e.id).toList());
    if (result.isNotEmpty) {
      return result[0];
    }
    return '';
  }

  Future<void> addTask() async {
    isLoading.value = false;
    final tz.TZDateTime deadline =
        tz.TZDateTime.parse(tz.local, deadlineController.value.text);
    final String subjectId = await getSubjectId(dropdownValue.value);
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);

    await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .doc(subjectId)
        .collection('tasks')
        .add({
      'detail': detailController.value.text.trim(),
      'deadline': deadlineController.value.text,
      'done': false,
    }).then((_) async {
      isLoading.value = true;
      if (deadline.subtract(const Duration(hours: 12)).isAfter(today)) {
        await service.showScheduledNotification(
          id: DateTime.now().millisecond,
          title: dropdownValue.value,
          body: '12 hours before task deadline!',
          notificationTime: tz.TZDateTime(tz.local, deadline.year,
                  deadline.month, deadline.day, deadline.hour, deadline.minute)
              .subtract(const Duration(hours: 12)),
        );
      }
      if (deadline.subtract(const Duration(minutes: 30)).isAfter(today)) {
        await service.showScheduledNotification(
          id: DateTime.now().millisecond + 1,
          title: dropdownValue.value,
          body: '30 minutes before task deadline!',
          notificationTime: tz.TZDateTime(tz.local, deadline.year,
                  deadline.month, deadline.day, deadline.hour, deadline.minute)
              .subtract(const Duration(minutes: 30)),
        );
      }
      Get.offAllNamed('/home');
    });
  }

  Future<List> getTasks(String subjectId) async {
    isLoading.value = true;
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .doc(subjectId)
        .collection('tasks')
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<String> getTaskId(String subjectId, String detail) async {
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .doc(subjectId)
        .collection('tasks')
        .where('detail', isEqualTo: detail)
        .get()
        .then((value) => value.docs.map((e) => e.id).toList()[0]);
  }

  Future<void> doneTask(String subjectName, String detail, bool isDone) async {
    final String subjectId = await getSubjectId(subjectName);
    final String taskId = await getTaskId(subjectId, detail);
    await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .doc(subjectId)
        .collection('tasks')
        .doc(taskId)
        .update({'done': isDone});
    await renderTasks(subjectName);
  }

  Future<void> removeTask(String subjectName, String detail) async {
    final String subjectId = await getSubjectId(subjectName);
    final String taskId = await getTaskId(subjectId, detail);
    await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .doc(subjectId)
        .collection('tasks')
        .doc(taskId)
        .delete();
    await renderTasks(subjectName);
  }
}
