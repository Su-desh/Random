import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Sending friend request
Widget addTofriendListRequest() {
  return const SizedBox(
    height: 40,
    width: 40,
    child: Column(
      children: [
        Text('Request'),
        ElevatedButton(onPressed: null, child: Text('Add Friend')),
      ],
    ),
  );
}

/// show this widget when the chat has been ended
Widget chatHasEnded() {
  return Padding(
    padding: const EdgeInsets.only(left: 10, bottom: 5),
    child: Card(
      elevation: 19,
      child: SizedBox(
        width: Get.width * 0.8,
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              style: TextStyle(fontSize: 20),
              'The chat with current user has been ended. press the button(skip to next) below to chat with new person.'),
        ),
      ),
    ),
  );
}
