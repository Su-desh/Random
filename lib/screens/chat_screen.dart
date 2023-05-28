import 'package:flutter/material.dart';
import 'package:random/conversation/chat_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
            ConversationList(
                name: 'Sudesh',
                isMessageRead: true,
                time: 'Today',
                messageText: 'Hello'),
            ConversationList(
                name: 'Manish',
                isMessageRead: false,
                time: 'Now',
                messageText: 'How are you ?'),
            ConversationList(
                name: 'Chetan',
                isMessageRead: true,
                time: 'Today',
                messageText: 'Where '),
            ConversationList(
                name: 'Zaheer',
                isMessageRead: false,
                time: 'Yesterday',
                messageText: 'What'),
            ConversationList(
                name: 'Nithin',
                isMessageRead: false,
                time: 'Today',
                messageText: 'Text me'),
            ConversationList(
                name: 'Pradeep',
                isMessageRead: true,
                time: 'Now',
                messageText: 'Send '),
            ConversationList(
                name: 'Anji',
                isMessageRead: false,
                time: '28 mar',
                messageText: 'Update'),
            ConversationList(
                name: 'Amar',
                isMessageRead: true,
                time: '5 Feb',
                messageText: 'Hello'),
            ConversationList(
                name: 'Mohan',
                isMessageRead: false,
                time: 'Today',
                messageText: 'Hi'),
            ConversationList(
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
