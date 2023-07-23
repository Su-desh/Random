import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
