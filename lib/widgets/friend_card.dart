import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/screens/conversation_screen.dart';
import 'package:random/widgets/more_vert.dart';

Widget friendCardWidget({required String username}) {
  return GestureDetector(
    onTap: () {
      Get.to(const ChatScreen());
    },
    child: Container(
      padding: const EdgeInsets.all(10.0),
      height: 120,
      child: Card(
          // elevation: 10,
          color: Colors.blue,
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
                      username[0],
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
                    username,
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
                moreVertBottomSheetWidget();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(Icons.more_vert),
              ),
            )
          ])),
    ),
  );
}
