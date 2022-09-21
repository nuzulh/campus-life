import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  final String? label;
  const MyBackButton({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 18.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
              onPressed: () {
                Get.back();
              },
              child: const Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black87,
              ),
            ),
            Text(label ?? '', style: Theme.of(context).textTheme.headline3),
          ],
        ),
      ),
    );
  }
}
