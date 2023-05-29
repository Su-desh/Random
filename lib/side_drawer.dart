import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    CupertinoColors.black,
                    CupertinoColors.activeBlue
                  ])),
              width: Get.width * 1,
              height: Get.height * 0.10,
              child: const Center(
                child: Text(
                  'UserName',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('    Share This App'),
                        onPressed: () {
                          Get.back();
                          Share.share(
                              'Click on the below link to chat with Random people .  https://play.google.com/store/apps/details?id=com.Ampereflow.chat ');
                        },
                      )
                    ]),
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                  child: TextButton.icon(
                icon: const Icon(Icons.star),
                label: const Text('     Rate This App'),
                onPressed: () {
                  Get.back();
                  StoreRedirect.redirect(androidAppId: 'com.Ampereflow.chat');
                },
              ))
            ]),
            Row(children: <Widget>[
              Expanded(
                  child: TextButton.icon(
                icon: const Icon(Icons.add_box),
                label: const Text('     More Apps     '),
                onPressed: () {
                  Get.back();
                },
              ))
            ]),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton.icon(
                    icon: const Icon(Icons.privacy_tip),
                    label: const Text('     Privacy Policy'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
