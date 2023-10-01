import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';

///class to manage the state of the meme page
class MemeState extends GetxController {
  ///scroll Controller
  final ScrollController memeScrollController = ScrollController();

  ///list of Meme Urls
  List<String> memeUrls = [];

  @override
  void onInit() {
    super.onInit();
    loadMemeFunc(howMany: 10);

    memeScrollController.addListener(() {
      if (memeScrollController.position.maxScrollExtent ==
          memeScrollController.position.pixels) {
        // Load more memes from the API
        loadMemeFunc(howMany: 10);
      }
    });
  }

  /// will be called when starting the app
  Future<void> loadMemeFunc({required int howMany}) async {
    for (int i = 0; i <= howMany; i++) {
      int randomSet = Random().nextInt(6) + 1; // set-1 to set-5
      int randomMemeNumber = Random().nextInt(101) + 1; //imge-1 to image-100

      try {
        final memeRef = await APIs.storage
            .ref()
            .child('memes/set-$randomSet/$randomMemeNumber.jpg')
            .getDownloadURL();
        // Check if the list contains the element.
        if (!memeUrls.contains(memeRef)) {
          // Add the element to the list only when it is not present already.
          memeUrls.add(memeRef);
          update();
        }
      } catch (e) {
        print('something went wrong !!!!, probaby the the url is not correct ');
        //continue to the next meme skipping this one
        continue;
      }
    }
  }
}
