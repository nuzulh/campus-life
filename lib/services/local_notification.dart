import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/subjects.dart';

class LocalNotification {
  final localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    return const NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await localNotificationService.show(id, title, body, details);
  }

  Future<void> showWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime notificationTime,
  }) async {
    final details = await _notificationDetails();
    await localNotificationService.zonedSchedule(
      id,
      title,
      body,
      notificationTime,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime notificationTime,
  }) async {
    final details = await _notificationDetails();
    await localNotificationService.zonedSchedule(
      id,
      title,
      body,
      notificationTime,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await _notificationDetails();
    await localNotificationService.show(id, title, body, details,
        payload: payload);
  }
}
