import 'package:get/get.dart';
import 'package:random/API/api.dart';

///class to manage the state of the friends page
class FriendState extends GetxController {
  /// storing all friends Uid
  List<String> friendUIdList = [];

  ///to get all friends UId
  void getChatUserFriendsFn() {
    friendUIdList = List<String>.from(APIs.me.friends_list);
    update();
  }
}
