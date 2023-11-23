import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initNotifications() async {
  var initializeAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializeIOS = IOSInitializationSettings();
  var initializationSettings =
      InitializationSettings(android: initializeAndroid, iOS: initializeIOS);

  await localNotificationsPlugin.initialize(initializationSettings);
}

Future singleNotification(
    DateTime scheduledDate, String title, String body, int hashCode,
    {String? sound}) async {
  var androidChannel = const AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
  );

  var iosChannel = IOSNotificationDetails();
  var platformChannel =
      NotificationDetails(android: androidChannel, iOS: iosChannel);

  localNotificationsPlugin.schedule(
      hashCode, title, body, scheduledDate, platformChannel,
      payload: hashCode.toString());
}
