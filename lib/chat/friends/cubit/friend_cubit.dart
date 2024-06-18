import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/API/api.dart';

part 'state_friend.dart';

///class to manage the state of the friends page
class FriendCubit extends Cubit<FriendInitial> {
  FriendCubit() : super(FriendInitial());

  /// storing all friends Uid
  List<String> friendUIdList = [];

  ///to get all friends UId
  void getChatUserFriendsFn() {
    friendUIdList = List<String>.from(APIs.me.friends_list);
    // update();
    emit(state);
  }
}
