import 'package:get/get.dart';

class UserData extends GetxController {
  late String userName;
  late bool isPermanentAccount;
  List<String> conversationList = [];
  List<String> friendList = [];

  getTheConversationListFunc() {
    conversationList = [];
  }

  getTheFriendListFunc() {
    friendList = [];
  }
}
