import 'package:flutter/material.dart';

import 'widgets/chat_input.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('no name'),
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
              chatInputWidget(),
            ],
          ))
        ],
      ),
    );
  }
}
