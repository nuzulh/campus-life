import 'package:campus_life/pages/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'schedule.dart';
import 'tasks.dart';

class PageTree extends StatelessWidget {
  const PageTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Home(),
      const Schedule(),
      const Tasks(),
      const Account(),
    ];
    RxInt selectedPage = 0.obs;

    void changePage(int index) {
      selectedPage.value = index;
    }

    return Obx(
      () => Scaffold(
        body: pages[selectedPage.value],
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(selectedPage.value == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(selectedPage.value == 1
                    ? FontAwesomeIcons.solidClock
                    : FontAwesomeIcons.clock),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(selectedPage.value == 2
                    ? FontAwesomeIcons.solidCalendarCheck
                    : FontAwesomeIcons.calendarCheck),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(selectedPage.value == 3
                    ? FontAwesomeIcons.solidUser
                    : FontAwesomeIcons.user),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedPage.value,
            selectedItemColor: const Color(0xFF3F8798),
            unselectedItemColor: const Color(0xFF3F8798),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            iconSize: 21.0,
            onTap: changePage,
          ),
        ),
      ),
    );
  }
}
