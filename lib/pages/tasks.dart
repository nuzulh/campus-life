import 'package:campus_life/components/header.dart';
import 'package:campus_life/components/secondary_bg.dart';
import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SecondaryBg(),
        SafeArea(
          child: Column(
            children: const [
              Header(title: 'Task', showBackButton: false),
            ],
          ),
        ),
      ],
    );
  }
}
