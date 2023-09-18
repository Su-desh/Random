import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/new_chat.dart';
import 'package:random/main.dart';

///basic dialogs Class
class Dialogs {
  ///Getx snackbar
  static void showGetSnackbar(String title, String msg) {
    Get.snackbar(title, msg, duration: const Duration(seconds: 2));
  }

  /// function to show snackbar with certain msg
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.blue.withOpacity(0.8),
        behavior: SnackBarBehavior.floating));
  }

  /// function to show progress indicator
  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }

  ///Connect with new stranger Function
  static Future<void> connectWithStranger() async {
    var connection = await netConnectivity.checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      if (newConnect.isConnected == false) {
        newConnect.funcForNewConnect();
      }
      Get.to(const ChatWithNewPerson());
    } else {
      print('not conected to any network ');
      Dialogs.netWorkAlert();
    }
  }

  ///function for showing a alert dialog (not connected to internet)
  static void netWorkAlert() {
    Get.defaultDialog(
      title: 'Network Error !!!',
      content: const Padding(
        padding: EdgeInsets.all(10.0),
        child:
            Text('Please connect with Mobile Internet or Wifi and try again.'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  ///success in signout dialog and to inform the restart of the app for proper functioning
  static void restartAppDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () async => false,
      title: 'Successful SignOut!',
      content: const Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Text(
            'Please Close the App Completely, Restart this App and LogIn again. '),
      ),
    );
  }
}
