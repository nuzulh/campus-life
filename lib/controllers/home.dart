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
  late RxList<DateTime> weekDates = <DateTime>[].obs;
  late RxInt day = 0.obs;
  late Rx<DateTime> firstDay = today;
  late RxInt selectedDay = 0.obs;
  late RxString time = ''.obs;
  late LocalNotification service;

  @override
  void onInit() {
    service = LocalNotification();
    listenToNotification();

    day.value = days.indexOf(days[today.value.weekday - 1]);
    firstDay.value = today.value.subtract(Duration(days: day.value));
    selectedDay.value = day.value;
    weekDates.value = getWeeksForRange(
        firstDay.value, firstDay.value.add(const Duration(days: 6)));

    time.value = formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());

    ever(selectedDay, renderSubjects);

    super.onInit();
  }

  List<DateTime> getWeeksForRange(DateTime start, DateTime end) {
    List<List<DateTime>> result = [];
    DateTime date = start;
    List<DateTime> week = [];

    while (date.difference(end).inDays <= 0) {
      if (date.weekday == 1 && week.isNotEmpty) {
        result.add(week);
        week = [];
      }
      week.add(date);
      date = date.add(const Duration(days: 1));
    }

    result.add(week);
    List<DateTime> weeks = <DateTime>[];
    for (List i in result) {
      for (DateTime x in i) {
        weeks.add(x);
      }
    }
    return weeks;
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Get.toNamed('/home');
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
