import 'dart:ui';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/controllers/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final int taskCount;
  final int index;
  final String subjectName;
  const TaskCard({
    Key? key,
    required this.task,
    required this.taskCount,
    required this.index,
    required this.subjectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    RxMap taskTemp = task.obs;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                height: Get.height / 1.8,
                width: Get.width - 36,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Deadline'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.calendar),
                        const SizedBox(width: 6.0),
                        Text(
                          task['deadline'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('Status'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(task['done']
                            ? CupertinoIcons.check_mark_circled_solid
                            : CupertinoIcons.xmark_circle_fill),
                        const SizedBox(width: 6.0),
                        Text(
                          task['done'] ? 'Done' : 'Not done yet',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('Task detail'),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Text(
                          task['detail'],
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                              child: const Icon(
                                CupertinoIcons.trash,
                                color: Colors.red,
                                size: 36.0,
                              ),
                              onPressed: () {}),
                          Text('Task: ${index + 1} / $taskCount'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width,
          child: Obx(
            () => Button(
              text: taskTemp['done'] ? 'Undone' : 'Done',
              icon: taskTemp['done']
                  ? CupertinoIcons.xmark
                  : CupertinoIcons.checkmark_alt,
              color: const Color(0xFF3F8798),
              onPressed: () {
                if (taskTemp['done']) {
                  taskController.doneTask(subjectName, task['detail'], false);
                } else {
                  taskController.doneTask(subjectName, task['detail'], true);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
