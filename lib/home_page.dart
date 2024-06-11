import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/conversations/conversation_screen.dart';
import 'package:random/chat/friends/cubit/friend_cubit.dart';
import 'package:random/home_screen.dart';
import 'package:random/chat/friends/friends_screen.dart';
import 'package:random/general/side_drawer.dart';
import 'package:random/memes/memes_page.dart';
import 'package:random/rooms/room_page.dart';

import 'general/theme_cubit.dart';

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
    context.watch<FriendCubit>().getChatUserFriendsFn();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          drawer: const SideDrawer(),
          appBar:
              AppBar(centerTitle: true, title: const Text('Random'), actions: [
            GestureDetector(
              onTap: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: context.watch<ThemeCubit>().state == ThemeMode.light
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
              ),
            ),
          ]),
          body: IndexedStack(index: _index, children: pages),
          bottomNavigationBar: CurvedNavigationBar(
            index: 1,
            backgroundColor: Colors.deepPurple,
            color: context.watch<ThemeCubit>().state == ThemeMode.light
                ? Colors.white
                : Colors.black87,
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
    );
  }
}
