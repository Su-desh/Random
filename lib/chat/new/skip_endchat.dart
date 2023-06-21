import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/new_user_state.dart';
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
                  await value.endThisConnectedChat();
                },
                child: const Text('End This Chat')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: GestureDetector(
                child: const Icon(Icons.person_add_alt_rounded)),
          )
        ],
      ),
    ),
  );
}
