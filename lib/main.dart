import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/friends/state_friend.dart';
import 'package:random/chat/new/state_new_user.dart';
import 'package:random/general/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //prevent user from taking screenshot
  //! i will uncomment this at production, it is giving error for web build
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const Random()));
}

/// instance of newConnect class
final newConnect = NewConnect();

/// instance of Friend Class
final friendClass = FriendState();

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
        //Execute the code here when user come back the app.
        //In my case, I needed to show if user active or not,
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: StreamBuilder(
          stream: APIs.firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //return const HomePage();
              APIs.updateActiveStatus(true);
              //calling this api to get the logged in user info
              APIs.getSelfInfo();
              return const SplashScreen();
            } else {
              //return const SignInScreen();
              APIs.updateActiveStatus(true);
              //calling this api to get the logged in user info
              APIs.getSelfInfo();
              return const SplashScreen();
            }
          }),
    );
  }
}
