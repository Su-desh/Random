import 'package:flutter/material.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Random'),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text("Online"),
        ),
      ),
      body: Container(
        color: Colors.green,
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.pink,
        // child: ,
      ),
    );
  }
}
