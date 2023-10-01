import 'package:flutter/material.dart';
import 'package:random/rooms/room_apis.dart';

///bottom sheet to create new room
class RoomCreateBottomSheet extends StatelessWidget {
  ///
  const RoomCreateBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Form(
        key: GlobalKey<FormState>(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Room name',
              ),
              validator: (value) {
                if (value!.length < 4) {
                  return 'Room name must be more than 4 characters';
                }
                return null;
              },
            ),
            const SwitchListTile(
              value: false,
              onChanged: null,
              title: Text('Private room'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Room description',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Room topic',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await RoomAPIs.createNewRoom();
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
