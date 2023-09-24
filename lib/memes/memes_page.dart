import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/main.dart';
import 'package:random/memes/meme_state.dart';

///Memes Page which will show memes to the users
class MemesPage extends StatefulWidget {
  ///
  const MemesPage({super.key});

  @override
  State<MemesPage> createState() => _MemesPageState();
}

class _MemesPageState extends State<MemesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemeState>(
      init: memeState,
      builder: (value) => ListView.builder(
        controller: value.memeScrollController,
        itemCount: value.memeUrls.length,
        itemBuilder: (BuildContext context, int index) {
          //load more memes when reached the bottom of the meme listview
          value.memeScrollController.addListener(() {
            if (value.memeScrollController.offset >=
                value.memeScrollController.position.maxScrollExtent) {
              value.loadMemeFunc(howMany: 5);
            }
          });
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 20,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Image.network(value.memeUrls[index]),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 08.0),
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //         onPressed: () {
                  //            },
                  //         icon: const Icon(Icons.download),
                  //       ),
                  //       IconButton(
                  //           onPressed: () {}, icon: const Icon(Icons.share))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
