import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';
import 'package:random/general/theme_cubit.dart';
import 'package:random/home_page.dart';
import 'package:random/memes/cubit/memes_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/signin.dart';
import 'chat/conversations/cubit/conversation_cubit.dart';
import 'chat/friends/cubit/friend_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //prevent user from taking screenshot
  // ! it is not supporting web so commenting it, in future i will use this.
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

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

///connectivity
final netConnectivity = Connectivity();

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
    return MultiBlocProvider(
      providers: [
        //theme cubit
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) =>
              ThemeCubit(sharedPreferences: sharedPreferences),
        ),
        //memes cubit
        BlocProvider<MemesCubit>(
          create: (BuildContext context) => MemesCubit(),
        ),
        //new user cubit
        BlocProvider<NewUserCubit>(
          create: (BuildContext context) => NewUserCubit(),
        ),
        //friends cubit
        BlocProvider<FriendCubit>(
          create: (BuildContext context) => FriendCubit(),
        ),
        //conversation cubit
        BlocProvider<ConversationCubit>(
          create: (BuildContext context) => ConversationCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeCubit>().getThemeData,
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
        );
      }),
    );
  }
}
