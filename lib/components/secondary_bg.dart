import 'package:flutter/material.dart';

class SecondaryBg extends StatelessWidget {
  const SecondaryBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF68E1FD),
          Colors.white,
        ],
      )),
    );
  }
}
