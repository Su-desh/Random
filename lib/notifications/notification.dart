import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///Class to work with notifications
class LocalNotificationService {
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///initialize
  static void initialize() {
    // Initialization setting for android
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@drawable/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
    Future.delayed(const Duration(seconds: 10), () {
      showNotification();
    });
  }

  ///show notification to the user
  static Future<void> showNotification() async {
    // To display the notification in device
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails("Channel Id", "Main Channel",
          importance: Importance.max, priority: Priority.high),
    );

    //show
    await _notificationsPlugin.show(
        id, 'Sudesh', 'hey Sudesh', notificationDetails);
  }
}
