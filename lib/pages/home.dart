import 'package:campus_life/components/day_card.dart';
import 'package:campus_life/components/header.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/schedule_card.dart';
import 'package:campus_life/components/welcome_card.dart';
import 'package:campus_life/components/secondary_bg.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:campus_life/screens/subject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: Stack(
        children: [
          const SecondaryBg(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(title: 'Home', showBackButton: false),
                const WelcomeCard(),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: Colors.black26,
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'Weekly schedule',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 4.0),
                          physics: const BouncingScrollPhysics(),
                          child: Obx(
                            () => Row(
                              children: [0, 1, 2, 3, 4, 5, 6]
                                  .map(
                                    (index) => DayCard(
                                      day: homeController.days[index],
                                      date:
                                          '${homeController.weekDates[index].day}',
                                      isSelected:
                                          homeController.selectedDay.value ==
                                              homeController.days.indexOf(
                                                  homeController.days[index]),
                                      onTap: () {
                                        homeController.selectedDay(
                                            homeController.days.indexOf(
                                                homeController.days[index]));
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        GetX<ScheduleController>(
                          init: ScheduleController(),
                          builder: (controller) => FutureBuilder(
                            future: controller.renderSubjects(
                                homeController.selectedDay.value),
                            builder: (context, snapshot) {
                              if (controller.isSubjectEmpty.value) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Text(
                                          'Your schedule is still empty! Please add your schedule:'),
                                    ),
                                    Button(
                                      text: 'SIMKULIAH USK',
                                      onPressed: () {
                                        Get.toNamed('/simkuliah-form');
                                      },
                                      img: 'assets/images/usk.png',
                                      color: const Color.fromARGB(
                                          255, 22, 156, 129),
                                    ),
                                  ],
                                );
                              }
                              if (controller.subjects.isNotEmpty) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 4.0),
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: controller.subjects
                                        .map(
                                          (subject) => ScheduleCard(
                                              onTap: () {
                                                Get.to(
                                                  () =>
                                                      Subject(subject: subject),
                                                );
                                              },
                                              subject: subject['name'],
                                              time: subject['time']),
                                        )
                                        .toList(),
                                  ),
                                );
                              }
                              if (controller.isLoading.value) {
                                return Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color: Colors.black54,
                                    size: 60.0,
                                  ),
                                );
                              }
                              return Center(
                                child: Image.asset(
                                  'assets/images/watermelon.png',
                                  width: Get.width / 1.5,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetX<ScheduleController>(
            init: ScheduleController(),
            builder: (controller) => FutureBuilder(
              future:
                  controller.renderSubjects(homeController.selectedDay.value),
              builder: (context, snapshot) {
                if (!controller.isSubjectEmpty.value) {
                  return Obx(
                    () => Positioned(
                      bottom: 8.0,
                      width: Get.width,
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.black26,
                            indent: 18.0,
                            endIndent: 18.0,
                          ),
                          Button(
                            text:
                                "Add ${homeController.days[homeController.selectedDay.value]}'s task",
                            color: const Color(0xFF3F8798),
                            icon: Icons.add_circle_outline,
                            onPressed: () {
                              if (controller.subjects.isNotEmpty) {
                                Get.toNamed('/task-form');
                              } else {
                                Get.snackbar(
                                  'Information',
                                  "You don't have any schedule today.",
                                  margin: const EdgeInsets.all(8.0),
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
