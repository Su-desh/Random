import 'package:flutter/material.dart';
import 'package:random/API/api.dart';

import '../../helper/my_date_util.dart';
import '../../models/chat_user.dart';

///App bar
class MyAppBar extends StatelessWidget {
  ///constructor
  const MyAppBar({super.key, required this.chat_user});

  ///other user data
  final ChatUser chat_user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //back button
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
        ),

        //user profile picture
        ClipRRect(
            child: CircleAvatar(
          child: Text(chat_user.username[0].toUpperCase()),
        )),

        //for adding some space
        const SizedBox(width: 10),

        //user name & last seen time
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //user name
            Text(
              chat_user.username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            //for adding some space
            const SizedBox(height: 2),

            //last seen time of user
            StreamBuilder(
                stream: APIs.getUserInfo(chat_user.user_UID),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    final thisDocData = snapshot.data?.docs.first;
                    ChatUser otherUser = ChatUser.fromJson(thisDocData!.data());

                    return Text(
                      otherUser.is_online
                          ? 'Online'
                          : MyDateUtil.getLastActiveTime(
                              context: context,
                              lastActive: chat_user.last_seen,
                            ),
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    );
                  }
                }),
          ],
        )
      ],
    );
  }
}
