import 'package:flutter/material.dart';
import 'package:random/rooms/screens/created_by_me.dart';
import 'package:random/rooms/screens/explore_rooms.dart';
import 'package:random/rooms/screens/joined_rooms.dart';

///Page to show the rooms in the app
class RoomPage extends StatefulWidget {
  ///
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TabBar
          SizedBox(
            height: 50,
            child: TabBar(
              controller: _tabController,
              tabs: const <Tab>[
                Tab(text: 'Rooms'),
                Tab(text: 'Explore'),
                Tab(text: 'My Rooms'),
              ],
            ),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                //user already joined rooms page
                JoinedRooms(),
                //find new rooms to join
                ExploreRooms(),
                //create new room so that others can join
                CreateRooms()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
