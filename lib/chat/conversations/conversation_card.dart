import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/conversations/cubit/conversation_cubit.dart';

import '../../helper/my_date_util.dart';
import '../../models/chat_user.dart';
import '../../models/message.dart';
import '../friends/chatting_screen.dart';

class ConversationCard extends StatefulWidget {
  const ConversationCard({
    super.key,
    required this.toName,
    required this.toUID,
  });

  final String toName;
  final String toUID;

  @override
  State<ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  //last message info (if null --> no message)
  Message? _message;
  //chat user details to chat with other person
  ChatUser? _chatUser;

  Future<void> getChatUser() async {
    await APIs.firestoreDB
        .collection("users")
        .where("user_UID", isEqualTo: widget.toUID)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        final thisDocData = querySnapshot.docs.first;
        _chatUser = ChatUser.fromJson(thisDocData.data());
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _chatUser == null ? await getChatUser() : null;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChattingScreenPage(
                user: _chatUser!,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: StreamBuilder(
          stream: context.read<ConversationCubit>().getLastMessage(widget.toUID),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) _message = list[0];

            return ListTile(
              leading: CircleAvatar(child: Text(widget.toName[0])),
              //user name
              title: Text(
                widget.toName,
                overflow: TextOverflow.ellipsis,
              ),

              //last message
              subtitle: Text(
                  _message != null
                      ? _message!.type == Type.image
                          ? 'image'
                          : _message!.msg
                      : 'no message !',
                  overflow: TextOverflow.ellipsis),

              //last message time
              trailing: _message == null
                  ? null //show nothing when no message is sent
                  : _message!.read.isEmpty && _message!.fromId != APIs.user.uid
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
                              context: context, time: _message!.sent),
                        ),
            );
          },
        ),
      ),
    );
  }
}
