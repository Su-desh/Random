import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random/main.dart';

class APIs {
  //Firestore Users reference
  var usersReference = firestoreDB.collection('users');

//add new user data to firestore
  addNewUserDataInFirestoreFunc(
      {required String username,
      required String userpass,
      required String userUUID}) async {
    final docData = {
      "blocked_list": [],
      "friends_list": [],
      "is_online": true,
      "is_searching_new": false,
      "created_at": Timestamp.now(),
      "last_seen": Timestamp.now(),
      "user_UID": userUUID,
      "useremail": "$username@gmail.com",
      "username": username,
      "userpass": userpass
    };

    try {
      await usersReference.add(docData);
      // ignore: avoid_print
      print('new user data added $docData');
    } catch (e) {
      // ignore: avoid_print
      print('this is the catch error $e');
    }
  }
}
