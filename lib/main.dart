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

  // The callback for our alarm
  static Future<void> callback() async {
    print('Alarm fired!');
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
          child: const Text("Press Me"),
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
