import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget moreVertBottomSheetWidget() {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.black87, Colors.lightBlue])),
    width: Get.size.width * 1,
    height: 200,
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Private message',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          onTap: () {
            
          },
        ),
        GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Remove Friend',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            onTap: () {}),
        const Divider(
          height: 1,
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Cancel',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          onTap: () {
            Get.back();
          },
        )
      ],
    ),
  );
}
