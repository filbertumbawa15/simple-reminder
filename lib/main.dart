import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
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
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
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
      home: const SetAlarmPage(),
    );
  }
}

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({Key? key}) : super(key: key);

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  final GlobalKey webViewKey = GlobalKey();

  static SendPort? uiSendPort;

  String text = "Berubah";

  InAppWebViewController? webViewController;

  int? timeDurationDelapan;
  int? timeDurationSetengahSembilan;
  int? timeDurationSembilan;
  int? timeDurationTiga;

  @pragma('vm:entry-point')
  static Future<void> callback8() async {
    print("baca Alarm");
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(const Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hallo Dari Program",
      "Pesan ini dikirim pada Jam 8 Pagi, mohon mendapatkan pesan, jika tidak, langsung hubungi pihak IT yang bersangkutan",
      hash,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callbacksetengah9() async {
    print("baca Alarm");
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(const Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hallo Dari Program",
      "Pesan ini dikirim pada Jam Setengah 9 Pagi, mohon mendapatkan pesan, jika tidak, langsung hubungi pihak IT yang bersangkutan",
      hash,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback9() async {
    print("baca Alarm");
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(const Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hallo Dari Program",
      "Pesan ini dikirim pada Jam 9 Pagi, mohon mendapatkan pesan, jika tidak, langsung hubungi pihak IT yang bersangkutan",
      hash,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback3() async {
    print("baca Alarm");
    var rand = Random();
    var hash = rand.nextInt(100);
    DateTime now = DateTime.now().toUtc().add(const Duration(seconds: 1));

    await notify.singleNotification(
      now,
      "Hallo Dari Program",
      "Pesan ini dikirim pada Jam 3 Sore, mohon mendapatkan pesan, jika tidak, langsung hubungi pihak IT yang bersangkutan",
      hash,
    );
  }

  @override
  void initState() {
    port.listen((data) async {
      // await showNotification(data);
    });
    //TimeDelapan
    DateTime timeDelapan = DateTime.now().toLocal();
    timeDelapan = DateTime(timeDelapan.year, timeDelapan.month, timeDelapan.day,
        8, 0, 0, timeDelapan.millisecond, timeDelapan.microsecond);
    if (DateTime.now().millisecondsSinceEpoch >
        timeDelapan.millisecondsSinceEpoch) {
      timeDurationDelapan = timeDelapan.millisecondsSinceEpoch +
          86400000 -
          DateTime.now().millisecondsSinceEpoch;
    } else {
      timeDurationDelapan = timeDelapan.millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch;
    }

    //timeSetengahSembilan
    DateTime timeSetengahSembilan = DateTime.now().toLocal();
    timeSetengahSembilan = DateTime(
        timeSetengahSembilan.year,
        timeSetengahSembilan.month,
        timeSetengahSembilan.day,
        8,
        30,
        0,
        timeSetengahSembilan.millisecond,
        timeSetengahSembilan.microsecond);
    if (DateTime.now().millisecondsSinceEpoch >
        timeSetengahSembilan.millisecondsSinceEpoch) {
      timeDurationSetengahSembilan =
          timeSetengahSembilan.millisecondsSinceEpoch +
              86400000 -
              DateTime.now().millisecondsSinceEpoch;
    } else {
      timeDurationSetengahSembilan =
          timeSetengahSembilan.millisecondsSinceEpoch -
              DateTime.now().millisecondsSinceEpoch;
    }

    //timeSembilan
    DateTime timeSembilan = DateTime.now().toLocal();
    timeSembilan = DateTime(
        timeSembilan.year,
        timeSembilan.month,
        timeSembilan.day,
        9,
        0,
        0,
        timeSembilan.millisecond,
        timeSembilan.microsecond);
    if (DateTime.now().millisecondsSinceEpoch >
        timeSembilan.millisecondsSinceEpoch) {
      timeDurationSembilan = timeSembilan.millisecondsSinceEpoch +
          86400000 -
          DateTime.now().millisecondsSinceEpoch;
    } else {
      timeDurationSembilan = timeSembilan.millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch;
    }

    //TimeTiga
    DateTime timeTiga = DateTime.now().toLocal();
    timeTiga = DateTime(timeTiga.year, timeTiga.month, timeTiga.day, 15, 0, 0,
        timeTiga.millisecond, timeTiga.microsecond);
    if (DateTime.now().millisecondsSinceEpoch >
        timeTiga.millisecondsSinceEpoch) {
      timeDurationTiga = timeTiga.millisecondsSinceEpoch +
          86400000 -
          DateTime.now().millisecondsSinceEpoch;
    } else {
      timeDurationTiga = timeTiga.millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch;
    }
    runAlarmDelapan();
    runAlarmSetengahSembilan();
    runAlarmSembilan();
    runAlarmTiga();
    print(timeDurationDelapan);
    print(timeDurationSetengahSembilan);
    print(timeDurationSembilan);
    print(timeDurationTiga);
    super.initState();
  }

  void runAlarmDelapan() async {
    await AndroidAlarmManager.oneShot(
      Duration(milliseconds: timeDurationDelapan!),
      0,
      callback8,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
    print("OK");
  }

  void runAlarmSetengahSembilan() async {
    await AndroidAlarmManager.oneShot(
      Duration(milliseconds: timeDurationSetengahSembilan!),
      2,
      callbacksetengah9,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
    print("OK");
  }

  void runAlarmSembilan() async {
    await AndroidAlarmManager.oneShot(
      Duration(milliseconds: timeDurationSembilan!),
      3,
      callback9,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
    print("OK");
  }

  void runAlarmTiga() async {
    await AndroidAlarmManager.oneShot(
      Duration(milliseconds: timeDurationTiga!),
      1,
      callback3,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
    print("OK");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // detect Android back button click
        final controller = webViewController;
        if (controller != null) {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
          body: Column(children: <Widget>[
        Expanded(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://asik.paskalapp.com")),
            // initialSettings:
            //     AndroidInAppWebViewSettings(allowsBackForwardNavigationGestures: true),
            onWebViewCreated: (controller) {
              webViewController = controller;

              // final int helloAlarmID = 0;
            },
            // shouldOverrideUrlLoading: (controller, navigationAction) async {
            //   if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
            //     final shouldPerformDownload =
            //         navigationAction.shouldPerformDownload ?? false;
            //     final url = navigationAction.request.url;
            //     if (shouldPerformDownload && url != null) {
            //       await downloadFile(url.toString());
            //       print(url);
            //       return NavigationActionPolicy.DOWNLOAD;
            //     }
            //   }
            //   return NavigationActionPolicy.ALLOW;
            // },
            // onDownloadStartRequest: (controller, downloadStartRequest) async {
            //   await downloadFile(downloadStartRequest.url.toString(),
            //       downloadStartRequest.suggestedFilename);
            // },
          ),
        ),
        ElevatedButton(
          key: const ValueKey('RegisterOneShotAlarm'),
          onPressed: () async {},
          child: const Text(
            'Schedule OneShot Alarm',
          ),
        ),
      ])),
    );
  }
}
