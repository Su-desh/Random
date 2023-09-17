import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/helper/dialogs.dart';
import 'package:random/main.dart';

/// blue line widget which will have options to skip end and add friend
class SkipToNextEndChat extends StatelessWidget {
  ///
  const SkipToNextEndChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewConnect>(
      init: newConnect,
      builder: (value) => Container(
        color: Colors.blue,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  value.funcForNewConnect();
                },
                child: const Text('Skip To Next')),
            if (value.isConnected)
              ElevatedButton(
                  onPressed: () async {
                    if (newConnect.isConnected) {
                      await value.endThisConnectedChat();
                    } else {
                      Dialogs.showGetSnackbar(
                        'error',
                        'you are not connected !!',
                      );
                    }
                  },
                  child: const Text('End This Chat')),
            if (value.isConnected)
              ElevatedButton(
                  onPressed: () async {
                    if (value.isConnected) {
                      //send friend request
                      String req = '[FRIEND_REQUEST]';
                      value.sendMessageOfNewConnect(
                          value.connectedWithChatUser, req);
                    } else {
                      Dialogs.showGetSnackbar(
                        'error',
                        'you are not connected !!',
                      );
                    }
                  },
                  child: const Icon(Icons.person_add_alt_rounded))
          ],
        ),
      ),
    );
  }
}
