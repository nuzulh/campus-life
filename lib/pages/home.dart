import 'package:campus_life/components/day_card.dart';
import 'package:campus_life/components/header.dart';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/welcome_card.dart';
import 'package:campus_life/components/schedule_card.dart';
import 'package:campus_life/components/secondary_bg.dart';
import 'package:campus_life/controllers/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Stack(
      children: <Widget>[
        const SecondaryBg(),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Header(title: 'Home', showBackButton: false),
              const WelcomeCard(),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(
                        color: Colors.black26,
                        indent: 18.0,
                        endIndent: 18.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'This week schedules',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 4.0),
                        physics: const BouncingScrollPhysics(),
                        child: Obx(
                          () => Row(
                            children: controller.days
                                .map(
                                  (day) => DayCard(
                                    day: day,
                                    date:
                                        '${controller.firstDay.value + controller.days.indexOf(day)}',
                                    isSelected: controller.selectedDay.value ==
                                        controller.days.indexOf(day),
                                    onTap: () {
                                      controller.selectedDay(
                                          controller.days.indexOf(day));
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 4.0),
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: <Widget>[
                            ScheduleCard(
                              subject: 'Keamanan Jaringan',
                              time: '08:00',
                              onTap: () {},
                            ),
                            ScheduleCard(
                              subject: 'Hardware-Software Co-Design',
                              time: '14:00',
                              onTap: () {},
                            ),
                            ScheduleCard(
                              subject: 'gtw wkwk wkwk wkwkw :v',
                              time: '99:00',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black26,
                        indent: 18.0,
                        endIndent: 18.0,
                      ),
                      Button(
                        text: 'Add Task for Today',
                        color: const Color(0xFF3F8798),
                        icon: Icons.add_circle,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
