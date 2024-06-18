import 'package:flutter/material.dart';
import 'package:random/helper/dialogs.dart';

import 'API/api.dart';

/// widget to show home Screen of the app
class HomeScreen extends StatefulWidget {
  // ignore: public_member_api_docs
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///for handling user feedback changes
  final _userFeedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              child: Card(
                elevation: 20,
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Hi, click on the Random Search button below to connect with a completely random stranger, you can chat with them and make new friends here .',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Dialogs.connectWithStranger(context: context);
              },
              child: const Text(
                'Random Search',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              child: Column(
                children: [
                  const Card(
                    color: Colors.blue,
                    elevation: 20,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "What can we do better? We're always looking for ways to improve our app. Share your feedback with us and help us make it the best it can be.",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    elevation: 20,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _userFeedbackController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 4,
                        decoration: const InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: TextStyle(),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_userFeedbackController.text.isNotEmpty) {
                  //feedback sending time
                  final time = DateTime.now().millisecondsSinceEpoch.toString();
                  //feedback data to send
                  var feedbackData = {
                    'user_name': APIs.me.username,
                    'user_id': APIs.me.user_UID,
                    'feedback': _userFeedbackController.text,
                    'time': time
                  };

                  // send the feedback
                  await APIs.firestoreDB
                      .collection('feedbacks')
                      .doc('${APIs.me.username}+$time')
                      .set(feedbackData);

                  //clear the feedback text after sending
                  _userFeedbackController.text = '';
                  setState(() {});
                }
              },
              child: const Text(
                'Send Feedback',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              child: Card(
                elevation: 20,
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Attention meme lovers! Our meme feature is the perfect place to get your daily dose of laughter. With a massive collection of memes, you're sure to find something to tickle your funny bone. And the best part is, you can share them with your friends.\nBottomSheet have a meme button in left side, click on it to see funny memes everyday.",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
