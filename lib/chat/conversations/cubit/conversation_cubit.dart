import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../API/api.dart';

part 'state_conversation.dart';

class ConversationCubit extends Cubit<ConversationInitial> {
  ConversationCubit() : super(ConversationInitial());

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
