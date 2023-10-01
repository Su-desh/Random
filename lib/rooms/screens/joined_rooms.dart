import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random/rooms/room_apis.dart';

///Widget for listing all the Rooms current user has joined
class JoinedRooms extends StatefulWidget {
  ///
  const JoinedRooms({super.key});

  @override
  State<JoinedRooms> createState() => _JoinedRoomsState();
}

class _JoinedRoomsState extends State<JoinedRooms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: FutureBuilder<QuerySnapshot>(
        future: RoomAPIs.roomsjoinedCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              if (snapshot.data!.docs.isNotEmpty) {
                ///get the room details
                final roomDoc = snapshot.data!.docs[index];
                final room = roomDoc.data()! as Map<String, dynamic>;

                //return the card widget to show the room details
                return Card(
                  child: ListTile(
                    title: Text(room['room_name']),
                    subtitle: Text(room['room_topic']),
                  ),
                );
              } else {
                const Center(
                  child: Text(
                    'List of all the Rooms you have joined will be shown here.',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
