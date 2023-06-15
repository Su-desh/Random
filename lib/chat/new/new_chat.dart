import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/models/chat_user.dart';
import 'package:random/chat/new/chat_input.dart';
import 'package:random/chat/new/skip_endchat.dart';

import '../../API/api.dart';
import '../../helper/message_card.dart';
import '../../models/message.dart';

class ChatWithNewPerson extends StatefulWidget {
  ChatUser user;
  ChatWithNewPerson({super.key, required this.user});

  @override
  State<ChatWithNewPerson> createState() => _ChatWithNewPersonState();
}

class _ChatWithNewPersonState extends State<ChatWithNewPerson> {
  //for storing all messages
  List<Message> _list = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 26, 101, 139),
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(45, 135, 130, 129),
              automaticallyImplyLeading: false,
              flexibleSpace: Row(
                children: [
                  //back button
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_sharp,
                            color: Colors.black54)),
                  ),

                  //user name & last seen time
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text('Random',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),

                      //for adding some space
                      SizedBox(height: 2),
                      //last seen time of user
                      Text('online status ',
                          style: TextStyle(fontSize: 13, color: Colors.black)),
                    ],
                  )
                ],
              )),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      //if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();

                      //if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => Message.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: _list.length,
                              padding: EdgeInsets.only(top: Get.height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MessageCard(message: _list[index]);
                              });
                        } else {
                          return const Center(
                            child: Text('Say Hii! 👋',
                                style: TextStyle(fontSize: 20)),
                          );
                        }
                    }
                  },
                ),
              ),

              //skip and end chat
              skipToNextEndChatWidget(),
              //chat input filed
              chatInputWidgetFunc(),
            ],
          ),
        ),
      ),
    );
  }
}
