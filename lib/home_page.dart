import 'package:flutter/material.dart';
import 'package:random/chat/conversations/conversation_screen.dart';
import 'package:random/home_screen.dart';
import 'package:random/chat/friends/friends_screen.dart';
import 'package:random/general/side_drawer.dart';

///Home page widget
class HomePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = const HomeScreen();
    switch (_index) {
      case 0:
        child = const HomeScreen();
        break;
      case 1:
        child = const ChatScreen();
        break;
      case 2:
        child = const PeopleScreen();
        break;
    }

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Random'),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "People"),
          ]),
    );
  }
}
