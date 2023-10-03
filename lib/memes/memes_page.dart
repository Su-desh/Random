import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/main.dart';
import 'package:random/memes/meme_state.dart';

/// Memes Page which will show memes to the users
class MemesPage extends StatelessWidget {
  ///
  const MemesPage({super.key});

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
                  //show meme image (white background while loading)
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/white_background.jpeg'),
                      image: NetworkImage(
                        value.memeUrls[index],
                      ),
                    ),
                  ),
                  // Row of Download and Share button
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                          onPressed: () {
                            //download the meme to local storage
                            MemeState.downloadMemeToUserStorage(
                              memeUrl: value.memeUrls[index],
                            );
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          onPressed: () {
                            //function to share memes
                            MemeState.shareTheMeme(
                              memeUrl: value.memeUrls[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
