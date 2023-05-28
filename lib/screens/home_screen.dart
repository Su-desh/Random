import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/new_chat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.blue,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Hi you will find the random chat here and you can est this i am writing just for filling the place i will chage this text later.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(const NewChatScreen());
                },
                child: const Text('Random'))
          ],
        ));
  }
}
