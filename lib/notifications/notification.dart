// ignore_for_file: public_member_api_docs, depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:random/API/api.dart';
import 'package:random/main.dart';

///Class to work with notifications
abstract class LocalNotificationService {
// Instance of Flutternotification plugin
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  ///background service
  static final _service = FlutterBackgroundService();

  ///initialize service
  static Future<void> initializeService() async {
    await _notificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher"),
      ),
    );
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(),
    );

    //start the service
    _service.startService();
    //set the service to background
    _service.invoke("setAsBackground");
  }

  @pragma('vm:entry-point')
  static Future<void> onStart(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    //check new notification
    checkForNewNotification();
  }

  static Future<void> checkForNewNotification() async {
    //notification related code
    print(
        "___________________________i am in the CheckForNewNotification function");
    await Firebase.initializeApp();
    APIs.firestoreDB
        .collection(
            'chats/${APIs.getConversationID('JhVglEz4UScBXMGYXnv1QJEFjBL2')}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
    conversationClass
        .getLastMessage('JhVglEz4UScBXMGYXnv1QJEFjBL2')
        .listen((event) {
      showNotification(
          senderName: '${event.docs.first.data()['fromId']}',
          msg: '${event.docs.first.data()['msg']}');
    });
  }

  ///show notification to the user
  static Future<void> showNotification(
      {required String senderName, required String msg}) async {
    //notification id
    int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    _notificationsPlugin.cancelAll();

    //details
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails("Channel Id", "Main Channel"),
    );
    //display notification
    await _notificationsPlugin.show(id, senderName, msg, notificationDetails);
  }
}
