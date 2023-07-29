import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/conversations/state_conversation.dart';
import 'package:random/chat/friends/state_friend.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/general/theme.dart';
import 'package:random/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/signin.dart';
import 'firebase_options.dart';
import 'notifications/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //prevent user from taking screenshot
  //! i will uncomment this at production, it is giving error for web build
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black, // transparent status bar
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const Random()));
}

///instance of sharedPreferences
late SharedPreferences sharedPreferences;

/// instance of newConnect class
final newConnect = NewConnect();

/// instance of Friend Class
final friendClass = FriendState();

///instance of conversation class
final conversationClass = ConversationState();

///theme
final themeNotifier = ThemeNotifier();

///First widget to be called from runApp();
class Random extends StatefulWidget {
  // ignore: public_member_api_docs
  const Random({super.key});
  @override
  State<Random> createState() => _RandomState();
}

class _RandomState extends State<Random> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Initialise  localnotification
    LocalNotificationService.initialize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        //I needed to show if user active or not,
        APIs.updateActiveStatus(true);
        break;
      case AppLifecycleState.paused:
        //Execute the code the when user leave the app
        APIs.updateActiveStatus(false);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeNotifier>(
      init: themeNotifier,
      builder: (value) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: value.lightMode! ? light_mode : dark_mode,
        home: Container(
          color: Colors.transparent,
          child: StreamBuilder(
            stream: APIs.firebaseAuth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
