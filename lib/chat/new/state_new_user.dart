import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/models/new_connect.dart';

import '../../models/message.dart';

/// New Connect state manager
class NewConnect extends GetxController {
  /// whether this user is connected with new user to chat
  bool isConnected = false;

  ///wheather to have circular progress
  bool showProgressIndicator = false;

  ///last message info (if null --> no message)
  Message? last_message;

  /// for storing Connected user information
  NewConnectedChatUser connectedWithChatUser = NewConnectedChatUser(
    is_online: true,
    is_searching_new: false,
    last_seen: '',
    user_UID: '',
    username: '',
  );

  /// This function is used for deciding wheather to find new connect
  /// or wait for it(other side user will connect with us)
  void funcForNewConnect() {
    int randomNum = Random().nextInt(2);
    if (randomNum == 0) {
      print("i am trying ggggggggggggggggggggggggg $randomNum");

      iAmTryingToFindNewUser();
    } else {
      print("i am waitinggggggggggggggggggggggggg $randomNum");

      iAmWaitingForNewConnect();
    }
  }

  /// i am trying to connect with new user
  Future<void> iAmTryingToFindNewUser() async {
    if (isConnected) {
      await endThisConnectedChat();
    }
    showProgressIndicator = true;
    update();
    // set this user searching true
    await updateSearchingField(true);

//search another user
    await APIs.firestoreDB
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
          //i_am_connected_to = 'connected user id'
          updateIamConnectedToField(connectedWithChatUser.user_UID);
          //update thier field and add my id to thier field
          updateTheirIamConnectedToField(connectedWithChatUser.user_UID);
          showProgressIndicator = false;
          update();
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  ///current user document reference
  var currentUserDocRef =
      APIs.firestoreDB.collection('users').doc(APIs.user.uid).snapshots();

  /// i am waiting for someone to update my i_am_connected_to filed to connected with them
  Future<void> iAmWaitingForNewConnect() async {
    if (isConnected) {
      await endThisConnectedChat();
    }
    showProgressIndicator = true;
    update();
    // set this user searching true
    await updateSearchingField(true);

// listen to changes in i_am_connected_to field so that i can update my UI(for new connect)
    currentUserDocRef.listen(
      (event) {
        Map<String, dynamic> data = event.data() as Map<String, dynamic>;
        if (data['i_am_connected_to'] != '') {
          //update my UI when the other person disconnected the chat with me
          isConnected = false;
          update();
        }
        //if i am connected to some user then update UI about that in order to chat with them
        else if (data['i_am_connected_to'] != '') {
          String connected_to_Id = data['i_am_connected_to'];
          APIs.firestoreDB.collection('users').doc(connected_to_Id).get().then(
            (DocumentSnapshot document) {
              Map<String, dynamic> connecterUserData =
                  document.data() as Map<String, dynamic>;
              //connected user info to chat with
              connectedWithChatUser =
                  NewConnectedChatUser.fromJson(connecterUserData);
            },
          );
        }
      },
    );
    isConnected = true;
    //now user is connected with someone
    updateSearchingField(false);
    //i_am_connected_to = 'connected user id'
    updateIamConnectedToField(connectedWithChatUser.user_UID);
    showProgressIndicator = false;
    update();
  }

  /// update i_am_connected_to field
  static Future<void> updateIamConnectedToField(String connectedToId) async {
    APIs.firestoreDB.collection('users').doc(APIs.user.uid).update({
      'i_am_connected_to': connectedToId,
    });
  }

  /// update my id to thier i_am_connected_to filed so that they can connect with me
  static Future<void> updateTheirIamConnectedToField(
      String connectedToId) async {
    APIs.firestoreDB.collection('users').doc(connectedToId).update({
      'i_am_connected_to': APIs.user.uid,
    });
  }

  /// update searching field bool
  static Future<void> updateSearchingField(bool isSearching) async {
    APIs.firestoreDB.collection('users').doc(APIs.user.uid).update({
      'is_searching_new': isSearching,
    });
  }

  /// This function will be triggered when the user want to end the chat completely
  Future<void> endThisConnectedChat() async {
    //remove the last message details
    last_message = null;
    //delete i_am_connected_to for me and the other side too

    //make my i_am_connected_to field empty
    await updateIamConnectedToField('');
    //update thier field so that thier UI show that the chat has ended
    await updateTheirIamConnectedToField('');

    //delete the temp chats
    String tempMsgPath =
        'temp/${APIs.getConversationID(connectedWithChatUser.user_UID)}/messages/';

    await APIs.firestoreDB.collection(tempMsgPath).get().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
          print('Deleted $ds');
        }
      },
    );
    isConnected = false;
    update();
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

    //send message
    final ref = APIs.firestoreDB.collection(
        'temp/${APIs.getConversationID(chatUser.user_UID)}/messages/');
    await ref.doc(time).set(message.toJson());

    // update the last msg
    final docRef = APIs.firestoreDB
        .collection('temp')
        .doc(APIs.getConversationID(chatUser.user_UID));

    //idea is to compare both and keep the small id first,
    //so that unnecssary write can be reduced
    //this list will help in fetching the conversation (since the 'where' was not suitable for 2-sided)
    int res = APIs.me.user_UID.compareTo(chatUser.user_UID);
    List toFrom = [];
    List userNames = [];
    if (res < 0) {
      //me.user_UID smaller
      toFrom = [APIs.me.user_UID, chatUser.user_UID];
      userNames = [APIs.me.username, chatUser.username];
    } else {
      // chatuser.UId smaller
      toFrom = [chatUser.user_UID, APIs.me.user_UID];
      userNames = [chatUser.username, APIs.me.username];
    }
    await docRef.set({'userNames': userNames, 'ToFrom': toFrom});
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessageOfNewConnect(
      NewConnectedChatUser user) {
    return APIs.firestoreDB
        .collection('temp/${APIs.getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
}
