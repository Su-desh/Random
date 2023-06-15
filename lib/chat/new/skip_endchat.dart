import 'package:flutter/material.dart';

Widget skipToNextEndChatWidget() {
  return Container(
    color: Colors.blue,
    height: 40,
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: TextButton(onPressed: null, child: Text('Skip To Next')),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: TextButton(onPressed: null, child: Text('End This Chat')),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child:
              GestureDetector(child: const Icon(Icons.person_add_alt_rounded)),
        )
      ],
    ),
  );
}
