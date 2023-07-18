import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random/models/chat_user.dart';

import '../models/message.dart';

///An API class to work with all required API requests
class APIs {
  /// for authentication
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// for accessing cloud firestore database
  static FirebaseFirestore firestoreDB = FirebaseFirestore.instance;

  /// for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  /// Firestore Users reference
  static var usersReference = firestoreDB.collection('users');

  /// Firestore Chats reference
  static var chatsReference = firestoreDB.collection('chats');

  /// to return current user
  static User get user => firebaseAuth.currentUser!;

  /// for storing self information
  static ChatUser me = ChatUser(
    blocked_list: [],
    friends_list: [],
    is_online: false,
    is_searching_new: false,
    created_at: '',
    last_seen: '',
    user_UID: '',
    useremail: '',
    username: '',
    userpass: '',
  );

  /// for getting current user info
  static Future<void> getSelfInfo() async {
    await firestoreDB
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) async {
      me = ChatUser.fromJson(user.data()!);

      //for setting user status to active
      APIs.updateActiveStatus(true);
      log('My Data: ${user.data()}');
    });
  }

  /// for creating a new user
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

  ///! very important func , used to genereate DOCUMENT id for chat
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

  /// for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestoreDB
        .collection('chats/${getConversationID(user.user_UID)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  /// for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      String userUid) {
    return firestoreDB
        .collection('users')
        .where('user_UID', isEqualTo: userUid)
        .snapshots();
  }

  ///  for sending message
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

// send the message
    final ref = firestoreDB
        .collection('chats/${getConversationID(chatUser.user_UID)}/messages/');
    await ref.doc(time).set(message.toJson());

    // update the last msg
    final docRef = firestoreDB
        .collection('chats')
        .doc(getConversationID(chatUser.user_UID));
    //idea is to compare both and keep the small id first,
    //so that unnecssary write can be reduced
    //this list will help in fetching the conversation (since the 'where' was not suitable for 2-sided)
    int res = me.user_UID.compareTo(chatUser.user_UID);
    List toFrom = [];
    List userNames = [];
    if (res < 0) {
      //me.user_UID smaller
      toFrom = [me.user_UID, chatUser.user_UID];
      userNames = [me.username, chatUser.username];
    } else {
      // chatuser.UId smaller
      toFrom = [chatUser.user_UID, me.user_UID];
      userNames = [chatUser.username, me.username];
    }
    await docRef.set({'userNames': userNames, 'ToFrom': toFrom});
  }

  ///update the last msg read status
  static Future<void> updateLastMsgReadStatus(String chatWithId) async {
    firestoreDB
        .collection('chats')
        .doc(getConversationID(chatWithId))
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  /// update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    //update last msg read status
    updateLastMsgReadStatus(message.fromId);
    //update the conversation msg read status
    firestoreDB
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  /// send chat image
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

  /// update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestoreDB.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_seen': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}
