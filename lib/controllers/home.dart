import 'dart:async';
import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/models/user.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  AuthController authController = Get.put(AuthController());

  final Rx<DateTime> today = DateTime.now().obs;
  final RxList<String> days =
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].obs;
  late RxInt day = 0.obs;
  late RxInt firstDay = 0.obs;
  late RxInt selectedDay = 0.obs;
  late RxString time = ''.obs;

  @override
  void onInit() {
    day.value = days.indexOf(days[today.value.weekday - 1]);
    firstDay.value = today.value.day - day.value;
    selectedDay.value = day.value;

    time.value = formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());

    ever(selectedDay, gas);

    super.onInit();
  }

  void gas(int index) {
    print(days[index]);
  }

  getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    time.value = formattedDateTime;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy hh:mm:ss').format(dateTime);
  }
}
