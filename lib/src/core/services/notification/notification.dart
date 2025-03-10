import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    await _localNotiInitialization();
    log('local notification setup.');
    await _onForegroundNoti();
    log('foreground notification setup.');
    await _onBackgroundNoti();
    log('background notification setup.');
  }

  static Future<void> _localNotiInitialization() async {
    final flutterLocalNotification = FlutterLocalNotificationsPlugin();
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();
    const initSetting = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting,
    );

    await flutterLocalNotification.initialize(initSetting);
  }

  static Future<void> _showLocalNotification({
    required String title,
    required String body,
  }) async {
    final flutterLocalNotification = FlutterLocalNotificationsPlugin();
    const notiDetail = NotificationDetails(
      android: AndroidNotificationDetails(
        'channelID',
        'channelName',
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotification.show(0, title, body, notiDetail);
  }

  static Future<void> _onForegroundNoti() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        await _showLocalNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
        );
      }
    });
  }

  static Future<void> _onBackgroundNoti() async {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      //     await Firebase.initializeApp();
      // print("Handling a background message: ${message.messageId}");
    });
  }
}
