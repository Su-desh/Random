import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random/API/api.dart';
import 'package:share_plus/share_plus.dart';

///class to manage the state of the meme page
class MemeState extends GetxController {
  ///scroll Controller
  final ScrollController memeScrollController = ScrollController();

  ///for downloading memes
  static final _dio = Dio();

  ///list of Meme Urls
  List<String> memeUrls = [];

  @override
  void onInit() {
    super.onInit();
    loadMemeFunc(howMany: 50);

    memeScrollController.addListener(() {
      if (memeScrollController.position.maxScrollExtent ==
          memeScrollController.position.pixels) {
        // Load more memes from the API
        loadMemeFunc(howMany: 10);
      }
    });
  }

  /// function to load memes
  Future<void> loadMemeFunc({required int howMany}) async {
    for (int i = 0; i <= howMany; i++) {
      int randomSet = Random().nextInt(10) + 1; //! set-1 to set-9
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
        print('something went wrong while loading meme $e');
        //continue to the next meme skipping this one
        continue;
      }
    }
  }

  ///function to share the meme
  ///it will download the meme in cache dir of app
  static Future<void> shareTheMeme({required String memeUrl}) async {
    try {
      String memeName =
          '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      // Get the directory for the app's cache
      final cacheDirectory = await getApplicationCacheDirectory();

      // Create a path for meme to download in app's cache directory
      final downloadPath = "${cacheDirectory.path}/memes/$memeName";
      // Save the meme image to the cache dir
      await _dio.download(memeUrl, downloadPath);

      // Share the file image
      if (await File(downloadPath).exists()) {
        Share.shareXFiles([XFile(downloadPath)],
            text:
                'Liked It? see more memes on our App  https://play.google.com/store/apps/details?id=com.Ampereflow.chat');
      }
    } catch (e) {
      print("errorrrr $e");
    }
  }

  ///function to download memes to user storage
  ///first it will download the img to cache directory
  ///then it  will copy the same file to user selected location
  ///and after that delete the img which was downloaded in cache dir
  static Future<void> downloadMemeToUserStorage(
      {required String memeUrl}) async {
    //if dir pic is not supported for device
    if (!await FlutterFileDialog.isPickDirectorySupported()) {
      print("Picking directory not supported");
      return;
    }

    final pickedDirectory = await FlutterFileDialog.pickDirectory();

    if (pickedDirectory != null) {
      try {
        String memeName =
            '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        // Get the directory for the app's cache
        final cacheDirectory = await getApplicationCacheDirectory();

        // Create a path for meme to download in app's cache directory
        final downloadPath = "${cacheDirectory.path}/memes/$memeName";
        // Save the meme image to the cache dir
        await _dio.download(memeUrl, downloadPath);

        ///save file
        final path = await FlutterFileDialog.saveFileToDirectory(
          directory: pickedDirectory,
          data: File(downloadPath).readAsBytesSync(),
          mimeType: "image/jpg",
          fileName: memeName,
        );

        //after the file is saved delete the img from cache dir
        await File(downloadPath).delete();

        //at completion show a Get snackbar
        Get.snackbar('Meme Downloaded!!', 'Meme Downloaded to Path $path',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue);
      } catch (e) {
        print('some errorr occurrreddd $e');
      }
    }
  }
}
