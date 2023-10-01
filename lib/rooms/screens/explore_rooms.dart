import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random/rooms/room_apis.dart';

///widget to explore all Rooms available so that user can join interesting rooms
class ExploreRooms extends StatefulWidget {
  ///
  const ExploreRooms({super.key});

  @override
  State<ExploreRooms> createState() => _ExploreRoomsState();
}

class _ExploreRoomsState extends State<ExploreRooms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: FutureBuilder<QuerySnapshot>(
        future: RoomAPIs.exploreRooms.get(),
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
                final exploreRoomsDoc = snapshot.data!.docs[index];
                final exploreRoom =
                    exploreRoomsDoc.data()! as Map<String, dynamic>;

                //return the card widget to show the room details
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    // height: 60,
                    child: Card(
                      child: ListTile(
                        title: Text(exploreRoom['room_name']),
                        subtitle: Text(exploreRoom['room_topic']),
                      ),
                    ),
                  ),
                );
              } else {
                const Center(
                  child: Text(
                    'List of all the Rooms you can join will be shown here.',
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
