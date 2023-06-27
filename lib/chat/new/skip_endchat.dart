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
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextButton(
                onPressed: () async {
                  await value.searchNewConnectFunc();
                },
                child: const Text('Skip To Next')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextButton(
                onPressed: () async {
                  if (newConnect.isConnected) {
                    await value.endThisConnectedChat();
                  } else {
                    Get.snackbar('error', 'you are not connected !!',
                        duration: const Duration(seconds: 2));
                  }
                },
                child: const Text('End This Chat')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: GestureDetector(
                onTap: () async {
                  if (newConnect.isConnected) {
                    //send friend request
                    
                  } else {
                    Get.snackbar('error', 'you are not connected !!',
                        duration: const Duration(seconds: 2));
                  }
                },
                child: const Icon(Icons.person_add_alt_rounded)),
          )
        ],
      ),
    ),
  );
}
