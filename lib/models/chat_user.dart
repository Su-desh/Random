/// User model for the required user
class ChatUser {
  // ignore: public_member_api_docs
  ChatUser(
      {required this.blocked_list,
      required this.friends_list,
      required this.is_online,
      required this.is_searching_new,
      required this.i_am_connected_to,
      required this.created_at,
      required this.last_seen,
      required this.user_UID,
      required this.useremail,
      required this.username,
      required this.userpass});

  /// blocked user list
  late List blocked_list;

  /// friends list
  late List friends_list;

  /// whether the user is online
  late bool is_online;

  /// whether the user is searching for new user to chat with
  late bool is_searching_new;

  /// with whom i am connected with
  late String i_am_connected_to;

  /// when this user account was created
  late String created_at;

  /// last seen of this user
  late String last_seen;

  /// unique Id to identify him/her
  late String user_UID;

  /// email of the user
  late String useremail;

  /// name of the user
  late String username;

  /// password of the user
  late String userpass;

  /// convert the json data to ChatUser Model data
  ChatUser.fromJson(Map<String, dynamic> json) {
    blocked_list = json['blocked_list'] ?? [];
    friends_list = json['friends_list'] ?? [];
    is_online = json['is_online'] ?? true;
    is_searching_new = json['is_searching_new'] ?? false;
    i_am_connected_to = json['i_am_connected_to'] ?? '';
    created_at = json['created_at'] ?? '';
    last_seen = json['last_seen'] ?? '';
    user_UID = json['user_UID'] ?? '';
    useremail = json['useremail'] ?? '';
    username = json['username'] ?? '';
    userpass = json['userpass'] ?? '';
  }

  /// convert ChatUser model to Json
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['blocked_list'] = blocked_list;
    data['friends_list'] = friends_list;
    data['is_online'] = is_online;
    data['is_searching_new'] = is_searching_new;
    data['i_am_connected_to'] = i_am_connected_to;
    data['created_at'] = created_at;
    data['last_seen'] = last_seen;
    data['user_UID'] = user_UID;
    data['useremail'] = useremail;
    data['username'] = username;
    data['userpass'] = userpass;

    return data;
  }
}
