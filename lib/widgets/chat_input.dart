import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget chatInputWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * .01, horizontal: Get.width * .025),
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
                      // FocusScope.of(context).unfocus();
                      // setState(() => _showEmoji = !_showEmoji);
                    },
                    icon: const Icon(Icons.emoji_emotions,
                        color: Colors.blueAccent, size: 25)),

                Expanded(
                    child: TextField(
                  // controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: () {
                    // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none),
                )),

                //pick image from gallery button
                IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      picker.pickImage(source: ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image,
                        color: Colors.blueAccent, size: 26)),

                //adding some space
                SizedBox(width: Get.width * .02),
              ],
            ),
          ),
        ),

        //send message button
        MaterialButton(
          onPressed: () {
            // if (_textController.text.isNotEmpty) {
            //   if (_list.isEmpty) {
            //     //on first message (add user to my_user collection of chat user)
            //     APIs.sendFirstMessage(
            //         widget.user, _textController.text, Type.text);
            //   } else {
            //     //simply send message
            //     APIs.sendMessage(
            //         widget.user, _textController.text, Type.text);
            //   }
            //   _textController.text = '';
            // }
          },
          minWidth: 0,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          shape: const CircleBorder(),
          color: Colors.green,
          child: const Icon(Icons.send, color: Colors.white, size: 28),
        )
      ],
    ),
  );
}
