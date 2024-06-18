import 'dart:developer' as developer;
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/friends/my_appbar.dart';

import '../../helper/message_card.dart';
import '../../models/chat_user.dart';
import '../../models/message.dart';

class ChattingScreenPage extends StatefulWidget {
  const ChattingScreenPage({super.key, required this.user});
  final ChatUser user;

  @override
  State<ChattingScreenPage> createState() => _ChattingScreenPageState();
}

class _ChattingScreenPageState extends State<ChattingScreenPage> {
  //for storing all messages
  List<Message> _list = [];

  //for handling message text changes
  final _textController = TextEditingController();

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  bool _showEmoji = false, _isUploading = false;

  //if emojis are shown & back button is pressed then hide emojis
  //or else simple close current screen on back button click
  Future<bool> _hideEmoji() {
    if (_showEmoji) {
      setState(() => _showEmoji = !_showEmoji);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  //pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    // Picking multiple images
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 40);
    // uploading & sending image one by one
    for (var i in images) {
      print('Image Path: ${i.path}');
      setState(() => _isUploading = true);
      await APIs.sendChatImage(widget.user, File(i.path));
      setState(() => _isUploading = false);
    }
  }

//take image from camera button
  Future<void> _takeImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    if (image != null) {
      developer.log('Image Path: ${image.path}');
      setState(() => _isUploading = true);

      await APIs.sendChatImage(widget.user, File(image.path));
      setState(() => _isUploading = false);
    }
  }

//send message
  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      APIs.sendMessage(widget.user, _textController.text, Type.text);
      _textController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: _hideEmoji,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: MyAppBar(chat_user: widget.user),
            ),
            backgroundColor: const Color.fromARGB(255, 26, 101, 139),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.user),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(message: _list[index]);
                                });
                          } else {
                            return const Center(
                              child: Text('Say Hii! 👋',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
                  ),
                ),

                //progress indicator for showing uploading
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: CircularProgressIndicator(strokeWidth: 2))),

                //chat input filed
                _chatInput(),

                //show emojis on keyboard emoji button click & vice versa
                if (_showEmoji)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: const Config(
                        bgColor: Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.width * 0.025),
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
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //pick image from gallery button
                  IconButton(
                      onPressed: _pickImageFromGallery,
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  //take image from camera button
                  IconButton(
                      onPressed: _takeImageFromCamera,
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
            onPressed: _sendMessage,
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
}
