import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/chatting_screen.dart';
import 'package:random/models/chat_user.dart';
import 'package:random/widgets/more_vert.dart';

Widget friendCardWidget({required context, required String uid}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    height: 120,
    child: Card(
        // elevation: 10,
        color: Colors.blue,
        child: FutureBuilder(
          future: APIs.getTheFriendUserNameUsingId(uid),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Text(
                'username',
                style: TextStyle(fontSize: 20),
              ));
            } else {
              return GestureDetector(
                onTap: () async {
                  ChatUser chatWith;
                  await APIs.usersReference.doc(uid).get().then((res) {
                    chatWith = ChatUser.fromJson(res.data()!);
                    Get.to(ChattingScreenPage(user: chatWith));
                  });
                },
                child: Row(children: <Widget>[
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          maxRadius: 20,
                          child: Text(
                            snapshot.data![0],
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
                          snapshot.data!,
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
                      showBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (builder) {
                            return moreVertBottomSheetWidget();
                          });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.more_vert),
                    ),
                  )
                ]),
              );
            }
          },
        )),
  );
}
