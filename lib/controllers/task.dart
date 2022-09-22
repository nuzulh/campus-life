import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  static TaskController get to => TaskController();

  Rx<TextEditingController> deadlineController = TextEditingController().obs;

  @override
  void onInit() {
    deadlineController.value.text =
        DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());
    super.onInit();
  }
}
