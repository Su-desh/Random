import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/conversations/conversation_card.dart';
import 'package:random/chat/conversations/cubit/conversation_cubit.dart';
import 'package:random/chat/new/new_conv_card.dart';
import 'package:random/helper/dialogs.dart';

/// Widget to show the list of all Conversations
class ConversationScreen extends StatefulWidget {
  // ignore: public_member_api_docs
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "your Conversations",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          //show 'anonymous chat listView
          const NewConnectConversationCard(),
          StreamBuilder<QuerySnapshot>(
            stream: context.read<ConversationCubit>().convSnap,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading..."));
              }
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ConversationCard(
                        //reciever name
                        toName: data['userNames'][0] == APIs.me.username
                            ? data['userNames'][1]
                            : data['userNames'][0],
                        //thier id
                        toUID: data['ToFrom'][0] == APIs.me.user_UID
                            ? data['ToFrom'][1]
                            : data['ToFrom'][0],
                      );
                    },
                  ).toList(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Dialogs.connectWithStranger(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
