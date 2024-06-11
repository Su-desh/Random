import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/friends/cubit/friend_cubit.dart';
import 'package:random/chat/friends/friend_card.dart';

/// widget to show all the friends list for this logged in user
class PeopleScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendCubit = context.watch<FriendCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
            child: Text(
              "your Friends",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        friendCubit.friendUIdList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendCubit.friendUIdList.length,
                  itemBuilder: (context, index) {
                    return FriendCard(
                        chatUserUId: friendCubit.friendUIdList[index]);
                  },
                ),
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Friends list is empty"),
                ),
              )
      ],
    );
  }
}
