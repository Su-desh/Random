import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random/models/chat_user.dart';

import '../models/message.dart';

class APIs {
  // for authentication
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestoreDB = FirebaseFirestore.instance;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //Firestore Users reference
  static var usersReference = firestoreDB.collection('users');
  //Firestore Chats reference
  static var chatsReference = firestoreDB.collection('chats');

  // to return current user
  static User get user => firebaseAuth.currentUser!;

//current user name
  static String currentUsersName = 'Username';

  // for creating a new user
  static Future<void> createUser({
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
  static Future<List> getAllFriendsForThisUserFunc() async {
    List friendsUidList = [];

    await usersReference.doc(user.uid).get().then((result) {
      friendsUidList = result.data()!['friends_list'];

      print("Friend list Success $friendsUidList");
    }, onError: (e) => print("Error completing: $e"));

    return friendsUidList;
  }

  //get the current user name
  static Future<void> getTheCurrentUsername() async {
    await usersReference.doc(user.uid).get().then((result) {
      currentUsersName = result.data()!['username'];

      print("user name Success $currentUsersName");
    }, onError: (e) => print("Error completing: $e"));
  }

//create a conversation
  static Future<void> createNewConversationFunc(
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

//! very important func , used to genereate DOCUMENT id for chat
  static String getConversationID(String id) {
    String currentUserId = user.uid;
    String chatWithUserId = id;
    //both user UID will be compared and smaller id will be first
    //with a _ and second id
    //eg smallerUID_greaterUID
    int result = currentUserId.compareTo(chatWithUserId);
    //both UID will never be equal, so no need of third conditon
    if (result < 0) {
      print('"$currentUserId" is less than "$chatWithUserId".');
      return '${currentUserId}_$chatWithUserId';
    } else {
      print('"$currentUserId" is greater than "$chatWithUserId".');
      return '${chatWithUserId}_$currentUserId';
    }
  }

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
      String userUid) {
    return firestoreDB
        .collection('users')
        .where('user_UID', isEqualTo: userUid)
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
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestoreDB
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
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

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestoreDB
        .collection('chats/${getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
}
