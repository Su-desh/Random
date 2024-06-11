import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';
import 'package:random/chat/new/new_chat.dart';
import 'package:random/main.dart';

///basic dialogs Class
class Dialogs {
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
  static Future<void> connectWithStranger(
      {required BuildContext context}) async {
    var connection = await netConnectivity.checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      if (context.read<NewUserCubit>().isConnected == false) {
        context.read<NewUserCubit>().funcForNewConnect();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const ChatWithNewPerson();
      }));
    } else {
      print('not conected to any network ');
      Dialogs.showNetworkAlertDialog(context);
    }
  }

  static void showNetworkAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Error!'),
          content: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                'Please connect with Mobile Internet or Wifi and try again.'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showRestartAppDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successful SignOut!'),
          content: const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Text(
                'Please Close the App Completely, Restart this App and LogIn again.'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
