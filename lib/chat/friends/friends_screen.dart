import 'package:flutter/material.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/friends/friend_card.dart';

/// widget to show all the friends list for this logged in user
class PeopleScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
            child: Text("your Friends",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: APIs.me.friends_list.length,
          itemBuilder: (context, index) {
            if (APIs.me.friends_list.isNotEmpty) {
              return friendCardWidget(
                  context: context, chatUserUId: APIs.me.friends_list[index]);
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Friends list is empty"),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
