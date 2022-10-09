import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;
  final Color color;
  final String? img;
  final double paddingX;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = Colors.black87,
    this.img,
    this.paddingX = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: 6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: text == '' ? 0.0 : 12.0),
                    child: Icon(icon, size: 28),
                  )
                : const SizedBox.shrink(),
            img != null
                ? Padding(
                    padding: EdgeInsets.only(right: text == '' ? 0.0 : 12.0),
                    child: Image.asset(
                      img ?? '',
                      width: 24.0,
                    ),
                  )
                : const SizedBox.shrink(),
            Text(
              text,
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}
