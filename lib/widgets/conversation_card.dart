import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/chatting_screen.dart';

Widget conversationCardWidget(
    {required String name,
    required String messageText,
    required String time,
    required bool isMessageRead}) {
  return GestureDetector(
    onTap: () {
      Get.to(const ChattingScreen());
    },
    child: Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30,
                  child: Text(name[0]),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          messageText,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: 12,
                color: isMessageRead ? Colors.blue : Colors.grey.shade300,
                fontWeight:
                    isMessageRead ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    ),
  );
}
