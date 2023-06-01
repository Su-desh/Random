import 'package:flutter/material.dart';
import 'package:random/widgets/friend_card.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("your Friends",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            friendCardWidget(username: 'Sudesh Sudesh sudesh sudesh'),
            friendCardWidget(username: 'Manish'),
            friendCardWidget(username: 'Chetan slfjakkkkkfsfsdf'),
            friendCardWidget(username: 'Zaheer'),
            friendCardWidget(username: 'Nithin'),
            friendCardWidget(username: 'Pradeep'),
            friendCardWidget(username: 'Anji'),
            friendCardWidget(username: 'Amar'),
            friendCardWidget(username: 'Mohan'),
            friendCardWidget(username: 'Sujan'),
          ],
        ),
      ),
    );
  }
}
