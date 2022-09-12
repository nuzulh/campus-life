import 'package:flutter/material.dart';

class PrimaryBg extends StatelessWidget {
  final bool isLeft;
  final bool isBottom;

  const PrimaryBg({
    Key? key,
    required this.isLeft,
    required this.isBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
          top: -size.width / 2,
          left: isLeft ? -size.width / 2 : size.width / 2,
          child: Container(
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(
              color: const Color(0xFF68E1FD),
              borderRadius: BorderRadius.circular(size.width),
            ),
          ),
        ),
        Positioned(
          top: size.height / 1.6,
          child: isBottom
              ? Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFF68E1FD),
                    borderRadius: BorderRadius.circular(30.0),
                  ))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
