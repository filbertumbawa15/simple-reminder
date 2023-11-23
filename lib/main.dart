import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:simple_reminder/notification_services.dart' as notify;

const String isolateName = 'isolate';
final ReceivePort port = ReceivePort();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  notify.initNotifications();
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SetAlarmPage(),
    );
  }
}

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({Key? key}) : super(key: key);

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  static SendPort? uiSendPort;

  String text = "Berubah";

  Future<void> showNotification(data) async {
    print(data);
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hello $hash",
      "This is hello message",
      hash,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    print("baca Alarm");
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hello $hash",
      "This is hello message",
      hash,
    );
    // // // This will be null if we're running in the background.
    // uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    // uiSendPort?.send("hi");
  }

  @override
  void initState() {
    port.listen((data) async {
      print("baca listen data");
      // await showNotification(data);
    });
    runAlarm();
    super.initState();
  }

  void runAlarm() async {
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 5),
      0,
      callback,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
    print("OK");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set an Alarm")),
      body: Center(
        child: ElevatedButton(
          child: Text(text),
          onPressed: () {
            // print("Press Me Button Pressed...");
            // setAlarm();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("asdf");
          },
          child: Icon(Icons.add)),
    );
  }

  // void setAlarm() async {
  //   print("setAlarm");
  //   final int alarmID = 1;
  //   await AndroidAlarmManager.oneShot(
  //       const Duration(seconds: 3), alarmID, printHello);
  // }

  // @pragma('vm:entry-point')
  // static void printHello() {
  //   print("baca sini");
  // }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await AndroidAlarmManager.initialize();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   bool isAppInForeground = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the local notifications plugin
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//     AndroidAlarmManager.oneShot(Duration(seconds: 10), 1, backgroundTask);

//     // Add lifecycle observer to detect when the app is in the foreground or background
//     WidgetsBinding.instance.addObserver(AppLifecycleObserver(this));
//   }

//   Future onSelectNotification(String? payload) async {
//     // Handle notification click event
//   }

//   Future<void> showNotification(String message) async {
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Alarm!',
//       message,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }

//   void backgroundTask() {
//     print("foreground");
//     // if (isAppInForeground) {
//     //   // App is in the foreground
//     //   // Perform foreground tasks
//     //   print("Foreground Task");
//     // } else {
//     //   // App is in the background
//     //   // Perform background tasks
//     //   showNotification("Your Flutter app is in the background.");
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Alarm Manager'),
//       ),
//       body: Center(
//         child: Text('Your Flutter app content goes here'),
//       ),
//     );
//   }
// }

// class AppLifecycleObserver extends WidgetsBindingObserver {
//   final _myHomePageState;

//   AppLifecycleObserver(this._myHomePageState);

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     _myHomePageState.setState(() {
//       if (state == AppLifecycleState.resumed) {
//         // App is in the foreground
//         _myHomePageState.isAppInForeground = true;
//       } else {
//         // App is in the background or inactive
//         _myHomePageState.isAppInForeground = false;
//       }
//     });
//   }
// }
