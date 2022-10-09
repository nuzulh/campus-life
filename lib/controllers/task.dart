import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  static TaskController get to => TaskController();
  final AuthController authController = Get.put(AuthController());
  final ScheduleController scheduleController = Get.put(ScheduleController());

  final List days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
  RxBool isLoading = false.obs;
  Rx<TextEditingController> deadlineController = TextEditingController().obs;
  Rx<TextEditingController> detailController = TextEditingController().obs;
  RxString dropdownValue = ''.obs;
  RxString subjectId = ''.obs;
  RxList tasks = [].obs;

  @override
  void onInit() {
    deadlineController.value.text =
        DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());
    dropdownValue.value = scheduleController.subjects[0]['name'];
    isLoading.value = true;
    super.onInit();
  }

  Future<void> renderTasks(String subjectName) async {
    subjectId.value = await getSubjectId(subjectName);
    tasks.value = await getTasks(subjectId.value);
    isLoading.value = false;
  }

  Future<String> getSubjectId(String subjectName) async {
    return await authController.db
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('schedule')
        .doc(HomeController.to.selectedDay.value.toString())
        .collection('subjects')
        .where('name', isEqualTo: subjectName)
        .get()
        .then((value) => value.docs.map((e) => e.id).toList()[0]);
  }

  Future<void> addTask() async {
    isLoading.value = false;
    final String subjectId = await getSubjectId(dropdownValue.value);
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
    }).then((_) {
      isLoading.value = true;
      Get.offAllNamed('/page-tree');
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

  Future<void> doneTask(String subjectName, String detail, bool status) async {
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
        .update({'done': status}).then((_) async {
      await renderTasks(subjectName);
    });
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
        .delete()
        .then((_) async {
      await renderTasks(subjectName);
    });
  }
}
