import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/friends/friend_card.dart';
import 'package:random/chat/friends/state_friend.dart';
import 'package:random/main.dart';

/// widget to show all the friends list for this logged in user
class PeopleScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FriendState>(
        init: friendClass,
        builder: (value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
                child: Text("your Friends",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
            value.friendUIdList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.friendUIdList.length,
                    itemBuilder: (context, index) {
                      return FriendCard(
                          chatUserUId: value.friendUIdList[index]);
                    },
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Friends list is empty"),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
