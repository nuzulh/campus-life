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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            onPressed: () {
              if (showBackButton) {
                Get.offNamed('/home');
              } else {
                Get.offNamed('/account');
              }
            },
            child: Icon(
              showBackButton ? Icons.close : CupertinoIcons.person_crop_circle,
              size: 28.0,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          CupertinoButton(
            onPressed: () {
              Get.toNamed('/settings');
            },
            child: const Icon(
              Icons.settings,
              size: 26.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
