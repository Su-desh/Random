import 'package:flutter/material.dart';
import 'package:random/main.dart';
import 'package:random/widgets/friend_card.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("your Friends",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: apis.getAllFriendsForThisUserFunc(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return friendCardWidget(
                              context: context,
                              uid: snapshot.data![index]);
                        },
                      );
                    } else {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Friends list is empty"),
                      ));
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
