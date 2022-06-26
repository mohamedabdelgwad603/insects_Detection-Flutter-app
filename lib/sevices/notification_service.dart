import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget {
  static final notification = FlutterLocalNotificationsPlugin();
  static Future init({bool scheduled = false}) async {
    var initAndroidSettings = AndroidInitializationSettings('bzz');
    final setting = InitializationSettings(android: initAndroidSettings);
    await notification.initialize(setting);
  }

  static Future showNotification(
      {var id = 0, var title, var body, var payload}) async {
    await notification.show(id, title, body, await notificationDetails());
  }

  static notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      //  sound: RawResourceAndroidNotificationSound('pop'),
      priority: Priority.high,
    ));
  }
}
