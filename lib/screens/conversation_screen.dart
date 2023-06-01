import 'package:flutter/material.dart';
import 'package:random/widgets/conversation_card.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("your conversations",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            conversationCardWidget(
                name: 'Sudesh ',
                isMessageRead: true,
                time: 'Today',
                messageText: 'Hello'),
            conversationCardWidget(
                name: 'Manish ',
                isMessageRead: false,
                time: 'Now',
                messageText:
                    'How are you ? i am just testing a feature sl;jkfddd'),
            conversationCardWidget(
                name: 'Chetan',
                isMessageRead: true,
                time: 'Today',
                messageText: 'Where '),
            conversationCardWidget(
                name: 'Zaheer',
                isMessageRead: false,
                time: 'Yesterday',
                messageText: 'What'),
            conversationCardWidget(
                name: 'Nithin',
                isMessageRead: false,
                time: 'Today',
                messageText: 'Text me'),
            conversationCardWidget(
                name: 'Pradeep',
                isMessageRead: true,
                time: 'Now',
                messageText: 'Send '),
            conversationCardWidget(
                name: 'Anji',
                isMessageRead: false,
                time: '28 mar',
                messageText: 'Update'),
            conversationCardWidget(
                name: 'Amar',
                isMessageRead: true,
                time: '5 Feb',
                messageText: 'Hello'),
            conversationCardWidget(
                name: 'Mohan',
                isMessageRead: false,
                time: 'Today',
                messageText: 'Hi'),
            conversationCardWidget(
                name: 'Sujan',
                isMessageRead: true,
                time: '6 Mar',
                messageText: 'sure'),
          ],
        ),
      ),
    );
  }
}
