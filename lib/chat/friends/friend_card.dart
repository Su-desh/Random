// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/friends/chatting_screen.dart';
import 'package:random/models/chat_user.dart';
import 'package:random/chat/friends/more_vert.dart';

class FriendCard extends StatelessWidget {
  final String chatUserUId;
  const FriendCard({super.key, required this.chatUserUId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 120,
      child: StreamBuilder(
        stream: APIs.getUserInfo(chatUserUId),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Text(
              'username',
              style: TextStyle(fontSize: 20),
            ));
          } else {
            final thisDocData = snapshot.data?.docs.first;
            ChatUser chatWithUser = ChatUser.fromJson(thisDocData!.data());

            return GestureDetector(
              onTap: () {
                Get.to(ChattingScreenPage(user: chatWithUser));
              },
              child: Card(
                elevation: 40,
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            maxRadius: 20,
                            child: Text(
                              chatWithUser.username[0],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: Text(
                            chatWithUser.username,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    )),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (builder) {
                            return FriendMoreVert(
                              chat_user: chatWithUser,
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(Icons.more_vert),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
