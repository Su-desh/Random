
import 'package:flutter/material.dart';
import 'package:random/screens/chat_screen.dart';
import 'package:random/screens/home_screen.dart';
import 'package:random/screens/people_screen.dart';

class HomePage extends StatefulWidget {
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
      drawer: const Drawer(),
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