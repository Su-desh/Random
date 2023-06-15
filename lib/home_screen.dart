import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/new/new_chat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Hi, click on the Random button below to connect with a completely random stranger, you can chat with them and make new friends here',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(
              ChatWithNewPerson(user: APIs.me),
            );
          },
          child: const Text('Random'),
        )
      ],
    );
  }
}
