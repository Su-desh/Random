import 'package:flutter/material.dart';

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
  return const Padding(
    padding: EdgeInsets.all(10.0),
    child: Text(
        'The chat with current has been ended. press the button below to chat with new person'),
  );
}
