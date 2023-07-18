// bottom chat input field
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/main.dart';

/// message input to send to the new connected user
class ChatMessageInput extends StatelessWidget {
  ///
  const ChatMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    //for handling message text changes
    final textController = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.01, horizontal: Get.width * 0.025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        Get.snackbar('emoji !!',
                            'add them to your firend list to send emoji');
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  IconButton(
                      onPressed: () {
                        Get.snackbar('message !!',
                            'you have to be friend with the user to share photo');
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  IconButton(
                      onPressed: () {
                        Get.snackbar('message',
                            'you have to be friend with the user to share photo');
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),

                  //adding some space
                  SizedBox(width: Get.width * 0.02),
                ],
              ),
            ),
          ),

          //send message button
          GetBuilder<NewConnect>(
            init: newConnect,
            // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
            builder: (val) => MaterialButton(
              onPressed: () {
                if (val.isConnected && textController.text.isNotEmpty) {
                  val.sendMessageOfNewConnect(
                      val.connectedWithChatUser, textController.text);
                  textController.text = '';
                }
              },
              minWidth: 0,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 10),
              shape: const CircleBorder(),
              color: val.isConnected ? Colors.green : Colors.red,
              child: const Icon(Icons.send, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
