// bottom chat input field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';

import '../../helper/dialogs.dart';

/// message input to send to the new connected user
class ChatMessageInput extends StatelessWidget {
  ///
  const ChatMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    //for handling message text changes
    final textController = TextEditingController();

    final newUserCubit = context.watch<NewUserCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.025),
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
                        Dialogs.showSnackbar(context,
                            'add them to your firend list to send emoji');
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  IconButton(
                      onPressed: () {
                        Dialogs.showSnackbar(context,
                            'you have to be friend with the user to share photo');
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  IconButton(
                      onPressed: () {
                        Dialogs.showSnackbar(context,
                            'you have to be friend with the user to share photo');
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),

                  //adding some space
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (newUserCubit.isConnected && textController.text.isNotEmpty) {
                newUserCubit.sendMessageOfNewConnect(textController.text);
                textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: newUserCubit.isConnected ? Colors.green : Colors.red,
            child: const Icon(Icons.send, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}
