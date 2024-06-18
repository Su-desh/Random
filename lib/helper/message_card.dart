import 'package:flutter/material.dart';
import 'package:random/chat/new/add_ended.dart';
import 'package:random/helper/image.dart';

import '../API/api.dart';
import '../helper/my_date_util.dart';
import '../models/message.dart';

/// for showing single message details
class MessageCard extends StatefulWidget {
  // ignore: public_member_api_docs
  const MessageCard({super.key, required this.message});

  // ignore: public_member_api_docs
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == widget.message.fromId;
    return InkWell(child: isMe ? _greenMessage() : _blueMessage());
  }

  // sender or another user message
  Widget _blueMessage() {
    //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        widget.message.msg == '[FRIEND_REQUEST]'
            ? const FriendRequest(
                canIadd: true,
              )
            : Flexible(
                child: Container(
                  padding: EdgeInsets.all(widget.message.type == Type.image
                      ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.04),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 245, 255),
                      border: Border.all(color: Colors.lightBlue),
                      //making borders curved
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: widget.message.type == Type.text
                      ?
                      //show text
                      Text(
                          widget.message.msg,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        )
                      :
                      //show image
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ShowImage(imageUrl: widget.message.msg);
                            }));
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 100,
                          ),
                        ),
                ),
              ),

        //message time
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),

            //double tick blue icon for message read
            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        widget.message.msg == '[FRIEND_REQUEST]'
            ? const FriendRequest(
                canIadd: false,
              )
            : Flexible(
                child: Container(
                  padding: EdgeInsets.all(widget.message.type == Type.image
                      ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.04),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .04,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 255, 176),
                      border: Border.all(color: Colors.lightGreen),
                      //making borders curved
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: widget.message.type == Type.text
                      ?
                      //show text
                      Text(
                          widget.message.msg,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        )
                      :
                      //show image
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ShowImage(imageUrl: widget.message.msg);
                            }));
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 100,
                          ),
                        ),
                ),
              ),
      ],
    );
  }
}
