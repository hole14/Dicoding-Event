import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

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
  static Future<void> schedulePreEventNotification({
    required int id,
    required String title,
    required String body,
    required DateTime beginTime,
    required bool isNotificationOn,
  })async{
    if(!isNotificationOn) return;

    final interval = 10;
    final offSet = 60;
    final now = DateTime.now();
    DateTime scheduledDate = beginTime.subtract(Duration(minutes: offSet));
    int i = 0;

    while(scheduledDate.isBefore(beginTime)){
      if (scheduledDate.isAfter(now)){
        await scheduleNotification(
          id: id * 100 + i,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
        );
      }
      scheduledDate = scheduledDate.add(Duration(minutes: interval));
      i++;
    }
  }
  static Future<void> cancelNotification(int id) async {
    for (int i = 0; i < 10; i++) {
      await _notification.cancel(id * 100 + i);
    }
  }
}