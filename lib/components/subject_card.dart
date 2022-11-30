import 'dart:ui';
import 'package:campus_life/components/button.dart';
import 'package:campus_life/screens/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectCard extends StatelessWidget {
  final Map<String, dynamic> subject;
  const SubjectCard({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const Text('Lecturer'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.person_alt),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            subject['lecturer'],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('NIP'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.creditcard_fill),
                        const SizedBox(width: 6.0),
                        Text(
                          subject['lecturer_id'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('Phone Number'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.phone_circle_fill),
                        const SizedBox(width: 6.0),
                        Text(
                          subject['phone_no'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('Room'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.map_pin_ellipse),
                        const SizedBox(width: 6.0),
                        Text(
                          subject['room'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width,
          child: Button(
            text: 'View Tasks',
            icon: CupertinoIcons.list_bullet,
            color: const Color(0xFF3F8798),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Task(subjectName: subject['name'])));
            },
          ),
        ),
      ],
    );
  }
}
