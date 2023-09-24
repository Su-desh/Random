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
    memeState.memeScrollController.addListener(() {
      if (memeState.memeScrollController.offset >=
          memeState.memeScrollController.position.maxScrollExtent) {
        memeState.loadMemeFunc(howMany: 5);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    memeState.memeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemeState>(
      init: memeState,
      builder: (value) => ListView.builder(
        controller: value.memeScrollController,
        itemCount: value.memeUrls.length,
        itemBuilder: (BuildContext context, int index) {
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
