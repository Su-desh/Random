import 'package:flutter/material.dart';
import 'package:random/widgets/skip_endchat.dart';

import '../widgets/chat_input.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

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
      body: Column(
        children: [
          Container(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              skipToNextEndChatWidget(),
              chatInputWidget(),
            ],
          ))
        ],
      ),
    );
  }
}
