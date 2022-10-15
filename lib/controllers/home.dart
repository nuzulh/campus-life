import 'dart:async';
import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/controllers/schedule.dart';
import 'package:campus_life/services/local_notification.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final AuthController authController = Get.put(AuthController());
  final ScheduleController scheduleController = Get.put(ScheduleController());

  final Rx<DateTime> today = DateTime.now().obs;
  final RxList<String> days =
      <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].obs;
  late RxInt day = 0.obs;
  late RxInt firstDay = 0.obs;
  late RxInt selectedDay = 0.obs;
  late RxString time = ''.obs;
  late LocalNotification service;

  @override
  void onInit() {
    service = LocalNotification();
    listenToNotification();

    day.value = days.indexOf(days[today.value.weekday - 1]);
    firstDay.value = today.value.day - day.value;
    selectedDay.value = day.value;

    time.value = formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());

    ever(selectedDay, renderSubjects);

    super.onInit();
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Get.toNamed('/page-tree');
    }
  }

  Future<void> renderSubjects(int index) async {
    await scheduleController.renderSubjects(selectedDay.value);
    await scheduleController.isSubjectsEmpty();
  }

  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    time.value = formattedDateTime;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy kk:mm:ss').format(dateTime);
  }
}
