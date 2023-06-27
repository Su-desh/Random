import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/models/chat_user.dart';
import 'package:random/models/new_connect.dart';

import '../../models/message.dart';

/// New Connect state manager
class NewConnect extends GetxController {
  /// whether this user is connected with new user to chat
  bool isConnected = false;

  /// for storing Connected user information
  NewConnectedChatUser connectedWithChatUser = NewConnectedChatUser(
    is_online: true,
    is_searching_new: false,
    last_seen: '',
    user_UID: '',
    username: '',
  );

  /// This function is used for searching the new user to chat with
  Future<void> searchNewConnectFunc() async {
    if (isConnected) {
      await endThisConnectedChat();
    }
    // set this user searching true
    updateSearchingField(true);
//search another user
    APIs.firestoreDB
        .collection("users")
        .where('user_UID',
            isNotEqualTo: APIs.me
                .user_UID) //this conditon becoz it should not connect with our acc
        .where("is_searching_new", isEqualTo: true)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        if (querySnapshot.docs.isEmpty) {
          print('searching users list is empty');
        } else if (querySnapshot.docs.isNotEmpty) {
          final connectedUserData = querySnapshot
              .docs[Random().nextInt(querySnapshot.docs.length)]
              .data();
          connectedWithChatUser =
              NewConnectedChatUser.fromJson(connectedUserData);
          isConnected = true;
          //now user is connected with someone
          updateSearchingField(false);

          update();
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  /// update searching field bool
  static Future<void> updateSearchingField(bool isSearching) async {
    APIs.firestoreDB.collection('users').doc(APIs.user.uid).update({
      'is_searching_new': isSearching,
    });
  }

  /// This function will be triggered when the user want to end the chat completely
  Future<void> endThisConnectedChat() async {
    await APIs.firestoreDB
        .collection(
            'temp/${APIs.getConversationID(connectedWithChatUser.user_UID)}/messages/')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        print('Deleted $ds');
      }
    });
    isConnected = false;
    update();
  }

  /// for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNewConnectedUserInfo(
      String userUid) {
    return APIs.firestoreDB
        .collection('users')
        .where('user_UID', isEqualTo: userUid)
        .snapshots();
  }

  /// for sending new message in chat
  Future<void> sendMessageOfNewConnect(
      NewConnectedChatUser chatUser, String msg) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //message to send
    final Message message = Message(
        toId: chatUser.user_UID,
        msg: msg,
        read: '',
        type: Type.text,
        fromId: APIs.user.uid,
        sent: time);

    final ref = APIs.firestoreDB.collection(
        'temp/${APIs.getConversationID(chatUser.user_UID)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  /// for getting all messages of a specific conversation from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessagesOfNewConnect(
      NewConnectedChatUser user) {
    return APIs.firestoreDB
        .collection('temp/${APIs.getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  /// get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessageOfNewConnect(
      ChatUser user) {
    return APIs.firestoreDB
        .collection('temp/${APIs.getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
}
