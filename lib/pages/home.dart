import 'package:campus_life/components/day_card.dart';
import 'package:campus_life/components/header.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/schedule_card.dart';
import 'package:campus_life/components/welcome_card.dart';
import 'package:campus_life/components/secondary_bg.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Stack(
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
                            children: homeController.days
                                .map(
                                  (day) => DayCard(
                                    day: day,
                                    date:
                                        '${homeController.firstDay.value + homeController.days.indexOf(day)}',
                                    isSelected:
                                        homeController.selectedDay.value ==
                                            homeController.days.indexOf(day),
                                    onTap: () {
                                      homeController.selectedDay(
                                          homeController.days.indexOf(day));
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
                          future: controller
                              .renderSubjects(homeController.selectedDay.value),
                          builder: (context, snapshot) {
                            if (controller.isSubjectEmpty.value) {
                              return Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Text(
                                        'Your schedule is still empty! Choose how you add schedules:'),
                                  ),
                                  Button(
                                    text: 'SIMKULIAH USK',
                                    onPressed: () {
                                      Get.toNamed('/simkuliah-form');
                                    },
                                    img: 'assets/images/usk.png',
                                    color:
                                        const Color.fromARGB(255, 22, 156, 129),
                                  ),
                                  Button(
                                    text: 'Add manually',
                                    onPressed: () {},
                                    icon: Icons.add_circle_outline,
                                    color: const Color(0xFF3F8798),
                                  ),
                                ],
                              );
                            }
                            if (controller.subjects.isEmpty) {
                              return Center(
                                child: Image.asset(
                                  'assets/images/watermelon.png',
                                  width: Get.width / 1.5,
                                ),
                              );
                            }
                            return Obx(
                              () => controller.isLoading.value
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                        color: Colors.black54,
                                        size: 60.0,
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0, vertical: 4.0),
                                      physics: const BouncingScrollPhysics(),
                                      child: Row(
                                        children: controller.subjects
                                            .map(
                                              (subject) => ScheduleCard(
                                                  onTap: () {},
                                                  subject: subject['name'],
                                                  time: subject['time']),
                                            )
                                            .toList(),
                                      ),
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
            future: controller.renderSubjects(homeController.selectedDay.value),
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
                            Get.toNamed('/task-form');
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
    );
  }
}
