import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random/API/api.dart';

///APIs for creating new Rooms and managing the existing rooms
abstract class RoomAPIs {
  ///rooms create by this user
  static final roomCreateByThisUser = APIs.firestoreDB
      .collection('rooms')
      .where('created_by', isEqualTo: APIs.user.uid);

  ///varialbe for fetching the already joined rooms of the users
  static final roomsjoinedCollection = APIs.firestoreDB
      .collection('rooms')
      .where('members', arrayContainsAny: [APIs.user.uid]);

  ///variable for fetching the rooms in which user can join
  static final exploreRooms = APIs.firestoreDB.collection('rooms');

  /// function to generate a unique room id
  static String _generateRoomId() {
    // Create a string of all possible characters.
    String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    // Generate a random string of 24(ROOM(4)+other 20) characters.
    String roomId = 'ROOM';
    //loop
    for (int i = 0; i < 20; i++) {
      roomId += characters[Random().nextInt(characters.length)];
    }
    return roomId;
  }

  /// function to create new room
  static Future<void> createNewRoom() async {
// creation time
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //generate a unique room ID
    String newRoomID = _generateRoomId();

    //details of the new room
    Map<String, dynamic> new_room_details = {
      'created_at': time,
      'created_by': APIs.user.uid,
      'members': [APIs.user.uid],
      'room_ID': newRoomID,
      'room_description': 'This is the Rooooooom Description  haahhahahaha',
      'room_name': 'MY rooom Name',
      'is_private': true,
      'room_topic': 'this is the topic of room'
    };

    //query to create new room
    await APIs.firestoreDB
        .collection('rooms')
        .doc(newRoomID)
        .set(new_room_details);

    await sendMessageToRoom(roomId: newRoomID, time: time);
  }

  ///send msg to the room
  static Future<void> sendMessageToRoom({
    required String roomId,
    required String time,
  }) async {
    //! send the first msg
    Map<String, dynamic> room_created_msg = {
      'msg': 'Room Created!!!',
      'sender_ID': APIs.user.uid,
      'sender_name': APIs.me.username,
      'time': time,
      'type': 'text'
    };

    //! room created now send the first msg (to create collection room_chats)
    await APIs.firestoreDB
        .collection('rooms')
        .doc(roomId)
        .collection('room_chats')
        .doc(time)
        .set(room_created_msg);
  }

  ///get list of all rooms where have joined
  static Future<QuerySnapshot<Map<String, dynamic>>> getJoinedRooms() {
    return APIs.firestoreDB
        .collection('rooms')
        .where('members', arrayContainsAny: [APIs.user.uid]).get();
  }
}

/// enum for the room msg types
// ignore: public_member_api_docs
enum Type { text, image }
