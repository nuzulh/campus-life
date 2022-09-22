import 'package:campus_life/components/button.dart';
import 'package:campus_life/components/header.dart';
import 'package:campus_life/components/secondary_bg.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Stack(
      children: [
        const SecondaryBg(),
        SafeArea(
          child: SizedBox(
            height: double.maxFinite,
            child: Column(
              children: [
                const Header(title: 'Account', showBackButton: false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        foregroundImage:
                            AssetImage('assets/images/profile.png'),
                        backgroundColor: Colors.white54,
                        radius: 76.0,
                      ),
                      CupertinoButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit profile',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 6.0),
                            const Icon(
                              FontAwesomeIcons.penToSquare,
                              color: Colors.black54,
                              size: 18.0,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${authController.user.value.firstName} ${authController.user.value.lastName}'),
                        ],
                      ),
                      const Divider(color: Colors.black26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(authController.user.value.email),
                        ],
                      ),
                      const Divider(color: Colors.black26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'University',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(authController.user.value.university),
                        ],
                      ),
                      const Divider(color: Colors.black26),
                      const SizedBox(height: 24.0),
                      Button(
                        text: 'Sign out',
                        icon: Icons.logout_outlined,
                        color: const Color(0xFF3F8798),
                        onPressed: authController.signOut,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
