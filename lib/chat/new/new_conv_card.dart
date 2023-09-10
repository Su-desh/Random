// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/new_chat.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/main.dart';

import '../../API/api.dart';
import '../../helper/my_date_util.dart';
import '../../models/message.dart';

class NewConnectConversationCard extends StatefulWidget {
  const NewConnectConversationCard({super.key});

  @override
  State<NewConnectConversationCard> createState() =>
      _NewConnectConversationCardState();
}

class _NewConnectConversationCardState
    extends State<NewConnectConversationCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewConnect>(
      init: newConnect,
      builder: (value) => GestureDetector(
        onTap: () {
          if (newConnect.isConnected == false) {
            newConnect.funcForNewConnect();
          }
          Get.to(const ChatWithNewPerson());
        },
        child: !newConnect.isConnected
            ? const Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                  title: Text('Anonymous',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.blue)),
                  subtitle: Text(
                    'Tap to Connect !',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: StreamBuilder(
                  stream: newConnect.getLastMessageOfNewConnect(
                      newConnect.connectedWithChatUser),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.docs;
                    final list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];
                    if (list.isNotEmpty) value.last_message = list[0];

                    return ListTile(
                      leading: const CircleAvatar(
                          backgroundColor: Colors.blue, child: Text('A')),
                      //user name
                      title: const Text(
                        'Anonymous',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.blue),
                      ),

                      //last message
                      subtitle: Text(
                          value.last_message != null
                              ? value.last_message!.type == Type.image
                                  ? 'image'
                                  : value.last_message!.msg
                              : 'send message !',
                          overflow: TextOverflow.ellipsis),

                      //last message time
                      trailing: value.last_message == null
                          ? null //show nothing when no message is sent
                          : value.last_message!.read.isEmpty &&
                                  value.last_message!.fromId != APIs.user.uid
                              ?
                              //show for unread message
                              Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent.shade400,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              :
                              //message sent time
                              Text(
                                  MyDateUtil.getLastMessageTime(
                                      context: context,
                                      time: value.last_message!.sent),
                                ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
