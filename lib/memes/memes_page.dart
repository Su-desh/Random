import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random/main.dart';
import 'package:random/memes/meme_state.dart';
import 'package:share_plus/share_plus.dart';

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
                  Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/white_background.jpeg'),
                        image: NetworkImage(
                          value.memeUrls[index],
                        ),
                      )),
                  //
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //!need to complete this in next release
                          },
                          icon: const Icon(Icons.download),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              // Get the directory for the app's cache
                              final cacheDirectory =
                                  await getApplicationCacheDirectory();

                              // Create a file in the app's cache directory
                              final downloadPath =
                                  "${cacheDirectory.path}/memes/${DateTime.now().toString()}.jpg";

                              // Save the meme image to the Pictures folder
                              await Dio().download(
                                  value.memeUrls[index], downloadPath);

                              // Share the file image
                              if (await File(downloadPath).exists()) {
                                Share.shareXFiles([XFile(downloadPath)],
                                    text:
                                        'Liked It? see more memes on our App  https://play.google.com/store/apps/details?id=com.Ampereflow.chat');
                              }
                            } catch (e) {
                              print("errorrrr $e");
                            }
                          },
                          icon: const Icon(Icons.share),
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
