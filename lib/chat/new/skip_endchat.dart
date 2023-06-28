import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/main.dart';

/// blue line widget which will have options to skip end and add friend
Widget skipToNextEndChatWidget() {
  return GetBuilder<NewConnect>(
    init: newConnect,
    builder: (value) => Container(
      color: Colors.blue,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                await value.searchNewConnectFunc();
              },
              child: const Text('Skip To Next')),
          ElevatedButton(
              onPressed: () async {
                if (newConnect.isConnected) {
                  await value.endThisConnectedChat();
                } else {
                  Get.snackbar('error', 'you are not connected !!',
                      duration: const Duration(seconds: 2));
                }
              },
              child: const Text('End This Chat')),
          ElevatedButton(
              onPressed: () async {
                if (newConnect.isConnected) {
                  //send friend request
                } else {
                  Get.snackbar('error', 'you are not connected !!',
                      duration: const Duration(seconds: 2));
                }
              },
              child: const Icon(Icons.person_add_alt_rounded))
        ],
      ),
    ),
  );
}
