import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/conversations/conversation_screen.dart';
import 'package:random/home_screen.dart';
import 'package:random/chat/friends/friends_screen.dart';
import 'package:random/general/side_drawer.dart';
import 'package:random/main.dart';
import 'package:random/memes/memes_page.dart';
import 'package:random/rooms/room_page.dart';

import 'general/theme.dart';

///Home page widget
class HomePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1;

  //list of all pages widget
  List<Widget> pages = const [
    MemesPage(),
    HomeScreen(),
    ConversationScreen(),
    RoomPage(),
    PeopleScreen()
  ];

  @override
  void initState() {
    super.initState();
    meInfo();
  }

  Future<void> meInfo() async {
    await APIs.getSelfInfo();
    print('${APIs.me.username} logged in !!!');
    print('This users friends list ${APIs.me.friends_list}');
    friendClass.getChatUserFriendsFn();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: GetBuilder<ThemeNotifier>(
          init: themeNotifier,
          builder: (value) => Scaffold(
            drawer: const SideDrawer(),
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Random'),
                actions: [
                  GestureDetector(
                    onTap: () {
                      value.toggleChangeTheme();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: value.lightMode!
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode),
                    ),
                  ),
                ]),
            body: IndexedStack(index: _index, children: pages),
            bottomNavigationBar: CurvedNavigationBar(
              index: 1,
              backgroundColor: Colors.deepPurple,
              color: value.lightMode! ? Colors.white : Colors.black87,
              height: 50,
              animationDuration: const Duration(milliseconds: 300),
              items: const <Widget>[
                Icon(Icons.local_fire_department, size: 25),
                Icon(Icons.home, size: 25),
                Icon(Icons.chat, size: 25),
                Icon(Icons.groups, size: 25),
                Icon(Icons.group, size: 25),
              ],
              onTap: (int index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
