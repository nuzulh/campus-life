import 'package:campus_life/components/back_button.dart';
import 'package:campus_life/components/primary_bg.dart';
import 'package:campus_life/components/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Subject extends StatelessWidget {
  final Map<String, dynamic> subject;
  const Subject({
    Key? key,
    required this.subject,
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
              Text(subject['name'],
                  style: Theme.of(context).textTheme.headline3),
              SubjectCard(subject: subject),
            ],
          ),
          const MyBackButton(label: 'Subject Details'),
        ],
      ),
    );
  }
}
