import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Center(
        child: LoadingAnimationWidget.horizontalRotatingDots(
          color: const Color(0xFF68E1FD),
          size: 80.0,
        ),
      ),
    );
  }
}
