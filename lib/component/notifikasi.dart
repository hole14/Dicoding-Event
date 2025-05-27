import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notification.initialize(settings);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledDate,
        tz.local
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main_Channel',
          channelDescription: 'Channel untuk event reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: 'event_reminder',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}