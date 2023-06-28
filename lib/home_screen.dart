import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/new_chat.dart';
import 'package:random/main.dart';

/// widget to show home Screen of the app
class HomeScreen extends StatelessWidget {
  // ignore: public_member_api_docs
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
          onPressed: () async {
            if (newConnect.isConnected == false) {
              await newConnect.searchNewConnectFunc();
            }
            Get.to(const ChatWithNewPerson());
          },
          child: const Text('Random'),
        )
      ],
    );
  }
}
