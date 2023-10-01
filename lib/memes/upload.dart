// // ignore_for_file: public_member_api_docs

// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random/API/api.dart';

// class MemeStorage {
// //upload meme num
//   static int memeNum = 0;
//   // take memes to upload
//   static Future<void> pickMultipleMemes() async {
//     final ImagePicker picker = ImagePicker();

//     // Picking multiple images
//     final List<XFile> images = await picker.pickMultiImage();

//     // uploading & sending image one by one
//     for (var i in images) {
//       print('Image Path: ${i.path}');

//       //inc num
//       memeNum++;
//       await uploadMeme(
//         file: File(i.path),
//         //!check this properly before upload uploade 5 sets
//         setNum: ,
//         memeNum: memeNum,
//       );
//       print('$i this meme is uploaded to firebase');
//     }
//   }

//   /// upload meme
//   static Future<void> uploadMeme(
//       {required File file, required int setNum, required int memeNum}) async {
//     //getting image file extension
//     final ext = file.path.split('.').last;

//     //storage file ref with path
//     final ref = APIs.storage.ref().child('memes/set-$setNum/$memeNum.$ext');

//     //uploading meme
//     await ref
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0) {
//       print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
//     });

//     print("MEEEEEEEmmmmmmmmmEEEEEEE in Set-$setNum and memeNUm $memeNum");
//   }
// }
