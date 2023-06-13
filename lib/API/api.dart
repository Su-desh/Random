import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random/main.dart';
import 'package:random/models/chat_user.dart';

import '../models/message.dart';

class APIs {
  //Firestore Users reference
  var usersReference = firestoreDB.collection('users');
  //Firestore Chats reference
  var chatsReference = firestoreDB.collection('chats');

  // to return current user
  static User get user => firebaseAuth.currentUser!;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

//current user name
  String currentUsersName = 'Username';

//test

  // for creating a new user
  Future<void> createUser({
    required String username,
    required String userpass,
  }) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      blocked_list: [],
      friends_list: [],
      is_online: true,
      is_searching_new: false,
      created_at: time,
      last_seen: time,
      user_UID: user.uid,
      useremail: user.email.toString(),
      username: username,
      userpass: userpass,
    );

    return await firestoreDB
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

//get all the friend of current user
  Future<List> getAllFriendsForThisUserFunc() async {
    List friendsUidList = [];

    await usersReference.doc(user.uid).get().then((result) {
      friendsUidList = result.data()!['friends_list'];

      print("Friend list Success $friendsUidList");
    }, onError: (e) => print("Error completing: $e"));

    return friendsUidList;
  }

//fetch the friend name using his/her id
  Future<String> getTheFriendUserNameUsingId(String id) async {
    String friendname = 'name';

    await usersReference.doc(id).get().then((res) {
      friendname = res.data()!['username'];
    }, onError: (e) => print('Error completing $e'));

    return friendname;
  }

  //get the current user name
  getTheCurrentUsername() async {
    await usersReference.doc(user.uid).get().then((result) {
      currentUsersName = result.data()!['username'];

      print("user name Success $currentUsersName");
    }, onError: (e) => print("Error completing: $e"));
  }

//create a conversation
  createNewConversationFunc(
      {required String fromUID,
      required String recieverUID,
      required String fromName,
      required String recieverName}) async {
    final newConversationDocData = {
      "from_UID": fromUID,
      "from_name": fromName,
      "reciever_UID": recieverUID,
      "reciever_name": recieverName,
    };
    print('im in the create new conv func');
    try {
      await chatsReference.add(newConversationDocData);
      // ignore: avoid_print
      print('new user data added $newConversationDocData');
    } catch (e) {
      // ignore: avoid_print
      print('this is the catch error $e');
    }
  }

//send a new message
  sendNewMessageFunc({required String message}) async {
    final newMessageData = {
      "message": message,
      "send_time": Timestamp.now(),
      "sender_uid": firebaseAuth.currentUser!.uid,
      "type": 'text',
    };

    try {
      await chatsReference
          .doc('aMJaSvaTg44z29vLMfbR')
          .collection('msglist')
          .add(newMessageData);
      // ignore: avoid_print
      print('new message data added $newMessageData');
    } catch (e) {
      // ignore: avoid_print
      print('this is the catch error $e');
    }
  }

  // useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestoreDB
        .collection('chats/${getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestoreDB
        .collection('users')
        .where('id', isEqualTo: chatUser.user_UID)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.user_UID,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firestoreDB
        .collection('chats/${getConversationID(chatUser.user_UID)}/messages/');
    await ref.doc(time).set(message.toJson());
    // sendPushNotification(chatUser, type == Type.text ? msg : 'image')
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestoreDB
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //delete message
  static Future<void> deleteMessage(Message message) async {
    await firestoreDB
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    // if (message.type == Type.image) {
    //   await storage.refFromURL(message.msg).delete();
    // }
  }

  //update message
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestoreDB
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.user_UID)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
