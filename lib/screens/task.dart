import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/components/task_card.dart';
import 'package:campus_life/controllers/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Task extends StatelessWidget {
  final String subjectName;
  const Task({
    Key? key,
    required this.subjectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PrimaryBg(isLeft: false, isBottom: false),
          Positioned(
            top: Get.height / 3,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset('assets/images/task.png'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 36.0),
              Text(subjectName, style: Theme.of(context).textTheme.headline3),
              GetX<TaskController>(
                init: TaskController(),
                builder: (controller) => FutureBuilder(
                  future: controller.renderTasks(subjectName),
                  builder: (context, snapshot) {
                    if (controller.tasks.isNotEmpty) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.tasks
                                .map(
                                  (task) => TaskCard(
                                    task: task,
                                    taskCount: controller.tasks.length,
                                    index: controller.tasks.indexOf(task),
                                    subjectName: subjectName,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    }
                    if (controller.isLoading.value) {
                      return Container(
                        color: Colors.white,
                        height: Get.height / 1.8,
                        width: Get.width,
                        child: Center(
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                            color: Colors.black54,
                            size: 60.0,
                          ),
                        ),
                      );
                    }
                    return Container(
                      color: Colors.white,
                      height: Get.height / 1.8,
                      width: Get.width,
                      child: const Center(
                        child: Text('no tasks'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const MyBackButton(label: 'Tasks'),
        ],
      ),
    );
  }
}
