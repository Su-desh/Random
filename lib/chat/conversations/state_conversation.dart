// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../API/api.dart';

class ConversationState extends GetxController {
//snapshot of all Conversations of this user
  final convSnap = APIs.firestoreDB
      .collection('chats')
      .where('ToFrom', arrayContains: APIs.user.uid)
      .snapshots();

  /// get only last message of a specific chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(String toUID) {
    return APIs.firestoreDB
        .collection('chats/${APIs.getConversationID(toUID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
}
