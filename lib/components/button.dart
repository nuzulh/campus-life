import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;
  final Color color;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
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
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(icon, size: 28),
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
