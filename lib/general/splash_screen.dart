import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/auth/signin.dart';
import 'package:random/home_page.dart';

import '../API/api.dart';

/// This widget will show the splash screen
class SplashScreen extends StatefulWidget {
  // ignore: public_member_api_docs
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (APIs.firebaseAuth.currentUser != null) {
        print('\nUser: ${APIs.firebaseAuth.currentUser}');
        //navigate to home screen
        Get.to(const HomePage());
      } else {
        //navigate to signin screen
        Get.to(const SignInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //app logo
        Positioned(
          top: Get.height * 0.15,
          right: Get.width * 0.25,
          width: Get.width * 0.5,
          child: Image.asset('assets/icon.png'),
        ),

        Positioned(
          bottom: Get.height * 0.15,
          width: Get.width,
          child: const Text(
            'DEVELOPED BY SUDESH',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, letterSpacing: 0.5),
          ),
        ),
      ]),
    );
  }
}
