import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/friends/chatting_screen.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';

import '../../API/api.dart';
import '../../models/chat_user.dart';

/// Sending friend request
class FriendRequest extends StatefulWidget {
  // ignore: public_member_api_docs
  const FriendRequest({super.key, required this.canIadd});

  ///who sent request
  final bool canIadd;

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  /// add the other person to friend list
  Future<void> addThisToFriendList() async {
    String thierId =
        context.read<NewUserCubit>().connectedWithChatUser.user_UID;
    await APIs.firestoreDB.collection('users').doc(APIs.user.uid).update({
      'friends_list': FieldValue.arrayUnion([thierId]),
    });

    await APIs.firestoreDB.collection('users').doc(thierId).get().then(
      (DocumentSnapshot document) {
        Map<String, dynamic> connecterUserData =
            document.data() as Map<String, dynamic>;
        //new friend info(Add Friend)
        ChatUser chatWithNewFriendData = ChatUser.fromJson(connecterUserData);
        //open the chatting page
        //!this will open the chat only on our side not the other side(to whom we chatting with)
        //!need to open the Chatting screen in thier screen too (I will solve this)
        ChattingScreenPage(
          user: chatWithNewFriendData,
        );
      },
    );

    //after opening the chatting screen with new friend
    //the app needs to delete the Anonymous chat with this person(New Friend)
    await context.read<NewUserCubit>().endThisConnectedChat();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: Colors.blue,
        child: Column(
          children: [
            Text(
              APIs.me.username,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 3.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: ElevatedButton(
                  onPressed: widget.canIadd
                      ?
                      //code to add the user to friend list
                      () async {
                          await addThisToFriendList();
                        }
                      : null,
                  child: const Text(
                    'Add Friend',
                    style: TextStyle(color: Colors.cyan),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

/// show this widget when the chat has been ended
class ChatHasEnded extends StatelessWidget {
  ///
  const ChatHasEnded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Card(
        elevation: 20,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                style: TextStyle(fontSize: 20),
                'The chat with current user has been ended. press the button(skip to next) below to chat with new person.'),
          ),
        ),
      ),
    );
  }
}
