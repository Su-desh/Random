import 'package:flutter/material.dart';
import 'package:random/rooms/create_room_modal_sheet.dart';

///widget to create Rooms so that other users can join them
///based on thier interest
class CreateRooms extends StatefulWidget {
  ///
  const CreateRooms({super.key});

  @override
  State<CreateRooms> createState() => _CreateRoomsState();
}

class _CreateRoomsState extends State<CreateRooms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //msg to to inform users about creating new rooms
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            color: Colors.purple,
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Looking for a way to stay connected with your friends? Create a room today and start chatting!",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        //button to create new room
        ElevatedButton(
          onPressed: () {
            // await RoomAPIs.createNewRoom();
            showModalBottomSheet(
              context: context,
              builder: (context) => const RoomCreateBottomSheet(),
            );
          },
          child: const Text(
            'Create New Room',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),

        ///list all the rooms create by this user
        // FutureBuilder<QuerySnapshot>(
        //   future: RoomAPIs.roomCreateByThisUser.get(),
        //   builder: (context, snapshot) {
        //     return ListView.builder(
        //       itemCount: snapshot.data!.docs.length,
        //       itemBuilder: (context, index) {
        //         if (snapshot.data!.docs.isNotEmpty) {
        //           ///get the room details
        //           final thisUserCreatedRoomsDoc = snapshot.data!.docs[index];
        //           final room =
        //               thisUserCreatedRoomsDoc.data()! as Map<String, dynamic>;

        //           //return the card widget to show the room details
        //           return SizedBox(
        //             height: 40,
        //             child: Card(
        //               child: ListTile(
        //                 title: Text(room['room_name']),
        //                 subtitle: Text(room['room_topic']),
        //               ),
        //             ),
        //           );
        //         }
        //         return null;
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }
}
