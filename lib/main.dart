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

    DateTime timeSetengahsembilan = DateTime.now().toLocal();
    timeSetengahsembilan = DateTime(
        timeSetengahsembilan.year,
        timeSetengahsembilan.month,
        timeSetengahsembilan.day,
        8,
        30,
        0,
        timeSetengahsembilan.millisecond,
        timeSetengahsembilan.microsecond);
    if (DateTime.now().millisecondsSinceEpoch >
        timeSetengahsembilan.millisecondsSinceEpoch) {
      timeDurationSetengahSembilan =
          timeSetengahsembilan.millisecondsSinceEpoch +
              86400000 -
              DateTime.now().millisecondsSinceEpoch;
    } else {
      timeDurationSetengahSembilan =
          timeSetengahsembilan.millisecondsSinceEpoch -
              DateTime.now().millisecondsSinceEpoch;
    }

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
      1,
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
      2,
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
      3,
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

  // Future<void> downloadFile(String url, [String? filename]) async {
  //   var hasStoragePermission = await Permission.storage.isGranted;
  //   if (!hasStoragePermission) {
  //     final status = await Permission.storage.request();
  //     hasStoragePermission = status.isGranted;
  //   }
  //   if (hasStoragePermission) {
  //     final taskId = await FlutterDownloader.enqueue(
  //         url: url,
  //         headers: {},
  //         // optional: header send with url (auth token etc)
  //         savedDir: (await getTemporaryDirectory()).path,
  //         saveInPublicStorage: true,
  //         fileName: filename);
  //   }
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
// import 'dart:developer' as developer;
// import 'dart:isolate';
// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// @pragma('vm:entry-point')
// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
// }

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await AndroidAlarmManager.initialize();

//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize(debug: true);
//   if (!kIsWeb &&
//       kDebugMode &&
//       defaultTargetPlatform == TargetPlatform.android) {
//     await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
//         kDebugMode);
//   }
//   runApp(const MaterialApp(home: MyApp()));
// }

// class TestClass {
//   static void callback(String id, DownloadTaskStatus status, int progress) {}
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final GlobalKey webViewKey = GlobalKey();

//   InAppWebViewController? webViewController;

//   ReceivePort _port = ReceivePort();

//   @override
//   void initState() {
//     super.initState();

//     // IsolateNameServer.registerPortWithName(
//     //     _port.sendPort, 'downloader_send_port');
//     // _port.listen((dynamic data) {
//     //   String id = data[0];
//     //   DownloadTaskStatus status = DownloadTaskStatus(data[1]);
//     //   int progress = data[2];
//     //   setState(() {});
//     // });

//     // FlutterDownloader.registerCallback(downloadCallback);
//   }

//   @override
//   void dispose() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//     super.dispose();
//   }

//   @pragma('vm:entry-point')
//   // static void downloadCallback(String id, int status, int progress) {
//   //   final SendPort? send =
//   //       IsolateNameServer.lookupPortByName('downloader_send_port');
//   //   send?.send([id, status, progress]);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // detect Android back button click
//         final controller = webViewController;
//         if (controller != null) {
//           if (await controller.canGoBack()) {
//             controller.goBack();
//             return false;
//           }
//         }
//         return true;
//       },
//       child: Scaffold(
//           body: Column(children: <Widget>[
//         Expanded(
//           child: InAppWebView(
//             key: webViewKey,
//             initialUrlRequest:
//                 URLRequest(url: Uri.parse("https://asik.paskalapp.com")),
//             // initialSettings:
//             //     InAppWebViewSettings(allowsBackForwardNavigationGestures: true),
//             onWebViewCreated: (controller) {
//               webViewController = controller;

//               // final int helloAlarmID = 0;
//             },
//             shouldOverrideUrlLoading: (controller, navigationAction) async {
//               if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
//                 // final shouldPerformDownload =
//                 //     navigationAction.shouldPerformDownload ?? false;
//                 final url = navigationAction.request.url;
//                 // if (shouldPerformDownload && url != null) {
//                 //   await downloadFile(url.toString());
//                 //   print(url);
//                 //   return NavigationActionPolicy.DOWNLOAD;
//                 // }
//               }
//               return NavigationActionPolicy.ALLOW;
//             },
//             // onDownloadStartRequest: (controller, downloadStartRequest) async {
//             //   await downloadFile(downloadStartRequest.url.toString(),
//             //       downloadStartRequest.suggestedFilename);
//             // },
//           ),
//         ),
//         ElevatedButton(
//           key: const ValueKey('RegisterOneShotAlarm'),
//           onPressed: () async {
//             await AndroidAlarmManager.periodic(
//                 const Duration(minutes: 1), 0, printHello);
//           },
//           child: const Text(
//             'Schedule OneShot Alarm',
//           ),
//         ),
//       ])),
//     );
//   }

//   // Future<void> downloadFile(String url, [String? filename]) async {
//   //   var hasStoragePermission = await Permission.storage.isGranted;
//   //   if (!hasStoragePermission) {
//   //     final status = await Permission.storage.request();
//   //     hasStoragePermission = status.isGranted;
//   //   }
//   //   if (hasStoragePermission) {
//   //     final taskId = await FlutterDownloader.enqueue(
//   //         url: url,
//   //         headers: {},
//   //         // optional: header send with url (auth token etc)
//   //         savedDir: (await getTemporaryDirectory()).path,
//   //         saveInPublicStorage: true,
//   //         fileName: filename);
//   //   }
//   // }
// }
