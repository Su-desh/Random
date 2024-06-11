import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random/auth/auth.dart';
import 'package:random/auth/signin.dart';
import 'package:random/general/privacy_policy.dart';
import 'package:random/helper/dialogs.dart';
import 'package:random/main.dart';
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
                    colors: [Colors.deepPurple, CupertinoColors.activeBlue],
                  ),
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.10,
                child: Center(
                  child: Text(
                    APIs.me.username,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Share.share(
                        'Click on the below link to chat with Random people and make new friends.  https://play.google.com/store/apps/details?id=com.Ampereflow.chat ');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        Text(
                          '    Share',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    StoreRedirect.redirect(androidAppId: 'com.Ampereflow.chat');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.star),
                        Text(
                          '    Rate',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ]),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  var connection = await netConnectivity.checkConnectivity();
                  if (connection == ConnectivityResult.mobile ||
                      connection == ConnectivityResult.wifi) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PrivacyPolicy();
                    }));
                  } else {
                    print('not conected to any network ');
                    Dialogs.showNetworkAlertDialog(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip),
                      Text('    Privacy Policy',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var connection = await netConnectivity.checkConnectivity();
                  if (connection == ConnectivityResult.mobile ||
                      connection == ConnectivityResult.wifi) {
                    await AuthService.signOutThisUser();
                    Navigator.pop(context);
                    print('current user ${APIs.me.username} sign out done !!!');
                    //go to signin page after signout because the conversation page
                    //will show error while the dialog box is displayed in foreground
                    //becoz the data is not loaded after signout
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
                    //show restart dialog
                    Dialogs.showRestartAppDialog(context);
                  } else {
                    print('not connected to network');
                    Navigator.pop(context);
                    Dialogs.showNetworkAlertDialog(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      Text('    Sign out', style: TextStyle(fontSize: 18)),
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
