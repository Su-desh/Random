import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import '../API/api.dart';

/// Widget to build the drawer
class SideDrawer extends StatelessWidget {
  // ignore: public_member_api_docs
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                        Colors.deepPurple,
                        CupertinoColors.activeBlue
                      ])),
                  width: Get.width * 1,
                  height: Get.height * 0.10,
                  child: Center(
                      child: Text(APIs.me.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)))),
              const Divider(
                thickness: 1,
              ),
              Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Share.share(
                        'Click on the below link to chat with Random people and make new friends.  https://play.google.com/store/apps/details?id=com.Ampereflow.chat ');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        Text('    Share', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    StoreRedirect.redirect(androidAppId: 'com.Ampereflow.chat');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.star),
                        Text('    Rate', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                )
              ]),
              GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip),
                      Text('    Privacy Policy', style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
