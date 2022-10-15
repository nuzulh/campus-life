import 'package:campus_life/components/auth_textfield.dart';
import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:campus_life/controllers/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final TaskController taskController = Get.put(TaskController());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  const PrimaryBg(isLeft: false, isBottom: false),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Select subject',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: taskController.dropdownValue.value,
                            onChanged: (String? value) {
                              taskController.dropdownValue.value = value!;
                            },
                            items: taskController.scheduleController.subjects
                                .map((subject) => DropdownMenuItem<String>(
                                    value: subject['name'],
                                    child: Text(subject['name'])))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Deadline',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextField(
                              labelText: '',
                              hintText: '',
                              readOnly: true,
                              controller:
                                  taskController.deadlineController.value,
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  onConfirm: (date) {
                                    taskController.deadlineController.value
                                        .text = date.toString().split('.')[0];
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en,
                                );
                              },
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.only(right: 18.0),
                            onPressed: () {
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                onConfirm: (date) {
                                  taskController.deadlineController.value.text =
                                      date.toString().split('.')[0];
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en,
                              );
                            },
                            child: const Icon(
                              CupertinoIcons.calendar,
                              color: Colors.black87,
                              size: 36.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Task Detail',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AuthTextField(
                        controller: taskController.detailController.value,
                        labelText: '',
                        hintText: 'Your task details',
                        maxLines: 5,
                      ),
                      Obx(
                        () => !taskController.isLoading.value
                            ? Center(
                                child: LoadingAnimationWidget
                                    .horizontalRotatingDots(
                                  color: Colors.black54,
                                  size: 60.0,
                                ),
                              )
                            : Button(
                                text: 'Add task',
                                onPressed: taskController.addTask,
                              ),
                      ),
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
