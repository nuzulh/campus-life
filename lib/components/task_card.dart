import 'dart:ui';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/controllers/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    final bool done = task['done'];
    RxBool isDone = done.obs;

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
                          DateFormat('dd-MM-yyyy kk:mm')
                              .format(DateTime.parse(task['deadline'])),
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
                    Obx(
                      () => Row(
                        children: [
                          Icon(isDone.value
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.xmark_circle_fill),
                          const SizedBox(width: 6.0),
                          Text(
                            isDone.value ? 'Done' : 'Not done yet',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                            onPressed: () {
                              Get.defaultDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                title: '',
                                titleStyle: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                content: const Text(
                                    'Are you sure to delete this task?'),
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
                                        text: 'Delete',
                                        color: Colors.red,
                                        onPressed: () async {
                                          await taskController.removeTask(
                                              subjectName, task['detail']);
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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
              text: isDone.value ? 'Undone' : 'Done',
              icon: isDone.value
                  ? CupertinoIcons.xmark
                  : CupertinoIcons.checkmark_alt,
              color: const Color(0xFF3F8798),
              onPressed: () {
                taskController.doneTask(
                    subjectName, task['detail'], !isDone.value);
                isDone.value = !isDone.value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
