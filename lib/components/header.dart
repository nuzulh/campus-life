import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const Header({
    Key? key,
    required this.title,
    required this.showBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            onPressed: () {
              if (showBackButton) {
                Get.back();
              }
            },
            child: Icon(
              showBackButton
                  ? Icons.chevron_left
                  : CupertinoIcons.calendar_today,
              size: showBackButton ? 38.0 : 26.0,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          CupertinoButton(
            onPressed: () {},
            child: const Icon(
              Icons.notifications,
              size: 26.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
