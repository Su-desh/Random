import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/new/add_ended.dart';
import 'package:random/chat/new/chat_input.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';
import 'package:random/chat/new/skip_endchat.dart';

import '../../helper/message_card.dart';
import '../../helper/my_date_util.dart';
import '../../models/message.dart';

/// widget to show the chatting page with the new connected user
class ChatWithNewPerson extends StatefulWidget {
  // ignore: public_member_api_docs
  const ChatWithNewPerson({super.key});

  @override
  State<ChatWithNewPerson> createState() => _ChatWithNewPersonState();
}

class _ChatWithNewPersonState extends State<ChatWithNewPerson> {
  //for storing all messages
  List<Message> _list = [];

  @override
  Widget build(BuildContext context) {
    final newUserCubit = context.watch<NewUserCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 26, 101, 139),
          appBar: AppBar(
            flexibleSpace: Row(
              children: [
                //back button
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),

                //user name & last seen time
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //user name
                    const Text('Anonymous',
                        // Text(value.connectedWithChatUser.username,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),

                    //for adding some space
                    const SizedBox(height: 2),
                    //last seen time of user
                    Text(
                      newUserCubit.connectedWithChatUser.is_online
                          ? 'Online'
                          : MyDateUtil.getLastActiveTime(
                              context: context,
                              lastActive:
                                  newUserCubit.connectedWithChatUser.last_seen),
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: newUserCubit.isConnected
                    ? StreamBuilder(
                        stream: newUserCubit.getAllMessagesOfNewConnect(),
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
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
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
                      )
                    : newUserCubit.showProgressIndicator
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.green),
                          )
                        : const Align(
                            alignment: Alignment.bottomCenter,
                            child: ChatHasEnded()),
              ),

              //skip and end chat
              const SkipToNextEndChat(),
              //chat input filed
              const ChatMessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
