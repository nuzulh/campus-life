import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final bool isPassword;
  final int maxLines;
  final Function()? onTap;
  final bool readOnly;

  const AuthTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        maxLines: maxLines,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          prefixIcon: icon != null ? Icon(icon, size: 18.0) : null,
        ),
      ),
    );
  }
}
