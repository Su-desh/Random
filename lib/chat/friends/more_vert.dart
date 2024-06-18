import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';

import 'chatting_screen.dart';
import '../../models/chat_user.dart';
import 'cubit/friend_cubit.dart';

///Widget which will be shown when the user click on 3 dots present on friend card
class FriendMoreVert extends StatelessWidget {
  // ignore: public_member_api_docs
  const FriendMoreVert({super.key, required this.chat_user});

  /// chatuser
  final ChatUser chat_user;

//function to remove the user from friend list
//it will also remove our name from thier friend list
  Future<void> _removeFromFriendList(BuildContext context) async {
    //remove from loggedin user friend list
    List<dynamic> otherUserUId = [chat_user.user_UID];
    await APIs.firestoreDB
        .collection('users')
        .doc(APIs.user.uid)
        .update({'friends_list': FieldValue.arrayRemove(otherUserUId)});

    //local changes
    context
        .read<FriendCubit>()
        .friendUIdList
        .removeWhere((element) => element == otherUserUId[0]);

    Navigator.pop(context);

    //remove from other user friend list(current user uid)
    List<dynamic> myUId = [APIs.user.uid];
    await APIs.firestoreDB
        .collection('users')
        .doc(chat_user.user_UID)
        .update({'friends_list': FieldValue.arrayRemove(myUId)});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              chat_user.username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Private message',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChattingScreenPage(user: chat_user);
              }));
            },
          ),
          GestureDetector(
            onTap: () {
              _removeFromFriendList(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Remove Friend',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 1),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
