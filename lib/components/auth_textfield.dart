import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  const AuthTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          prefixIcon: Icon(icon, size: 18.0),
        ),
      ),
    );
  }
}
