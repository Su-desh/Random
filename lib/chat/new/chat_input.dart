// bottom chat input field
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';

Widget chatInputWidgetFunc() {
  //for handling message text changes
  final _textController = TextEditingController();

  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.01, horizontal: Get.width * 0.025),
    child: Row(
      children: [
        //input field & buttons
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: () {},
                  decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none),
                )),

                IconButton(
                    onPressed: () {
                      Get.snackbar('message !!',
                          'you have to be friend with the user to send them photo');
                    },
                    icon: const Icon(Icons.image,
                        color: Colors.blueAccent, size: 26)),

                IconButton(
                    onPressed: () {
                      Get.snackbar('message',
                          'you have to be friend with the user to send them photo');
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
        MaterialButton(
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              // APIs.sendMessage(widget.user, _textController.text, Type.text);
              _textController.text = '';
            }
          },
          minWidth: 0,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          shape: const CircleBorder(),
          color: Colors.green,
          child: const Icon(Icons.send, color: Colors.white, size: 30),
        )
      ],
    ),
  );
}
