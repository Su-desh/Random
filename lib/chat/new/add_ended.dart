import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../API/api.dart';

/// Sending friend request
class FriendRequest extends StatelessWidget {
  // ignore: public_member_api_docs
  const FriendRequest({super.key, required this.canIadd});

  ///who sent request
  final bool canIadd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: Colors.blue,
        child: Column(
          children: [
            Text(
              APIs.me.username,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 3.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: ElevatedButton(
                  onPressed: canIadd
                      ?
                      //code to add the user to friend list
                      () {}
                      : null,
                  child: const Text(
                    'Add Friend',
                    style: TextStyle(color: Colors.cyan),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

/// show this widget when the chat has been ended
class ChatHasEnded extends StatelessWidget {
  ///
  const ChatHasEnded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Card(
        elevation: 20,
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
}
