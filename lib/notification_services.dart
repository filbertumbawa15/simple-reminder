import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

tz.TZDateTime? dateTime;

Future<void> initNotifications() async {
  tzdata.initializeTimeZones();
  var initializeAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  // var initializeIOS = IOSInitializationSettings();
  var initializationSettings =
      InitializationSettings(android: initializeAndroid);

  localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await localNotificationsPlugin.initialize(initializationSettings);
}

Future singleNotification(
  String title,
  String body,
  int hashCode,
) async {
  // var vibrationPattern = Int64List(4);
  // vibrationPattern[0] = 0;
  // vibrationPattern[1] = 1000;
  // vibrationPattern[2] = 5000;
  // vibrationPattern[3] = 2000;
  dateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
  var androidChannel = const AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    sound: RawResourceAndroidNotificationSound('bang_ada_telfon'),
    // largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    visibility: NotificationVisibility.public,
  );

  // var iosChannel = IOSFlutterLocalNotificationsPlugin();
  var platformChannel = NotificationDetails(android: androidChannel);

  localNotificationsPlugin.zonedSchedule(
    hashCode,
    title,
    body,
    dateTime!,
    platformChannel,
    payload: hashCode.toString(),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

// void showCustomNotification(String title, String body) {
//   showOverlayNotification(
//     (context) {
//       return OverlaySupport(
//         leading: IconButton(
//           icon: Icon(Icons.snooze),
//           onPressed: () {
//             // Handle snooze action
//           },
//         ),
//         title: title,
//         subtitle: body,
//         onTap: () {
//           // Handle tap on notification
//         },
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               // Handle dismiss action
//             },
//           ),
//         ],
//       );
//     },
//     duration: Duration(milliseconds: 4000),
//   );
// }
