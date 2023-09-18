import 'package:flutter/material.dart';
import 'package:random/helper/dialogs.dart';

/// widget to show home Screen of the app
class HomeScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
            child: Card(
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
              Dialogs.connectWithStranger();
            },
            child: const Text(
              'Random Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
