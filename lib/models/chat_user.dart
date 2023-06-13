class ChatUser {
  ChatUser(
      {required this.blocked_list,
      required this.friends_list,
      required this.is_online,
      required this.is_searching_new,
      required this.created_at,
      required this.last_seen,
      required this.user_UID,
      required this.useremail,
      required this.username,
      required this.userpass});

  late List blocked_list;
  late List friends_list;
  late bool is_online;
  late bool is_searching_new;
  late String created_at;
  late String last_seen;
  late String user_UID;
  late String useremail;
  late String username;
  late String userpass;

  ChatUser.fromJson(Map<String, dynamic> json) {
    blocked_list = json['blocked_list'] ?? [];
    friends_list = json['friends_list'] ?? [];
    is_online = json['is_online'] ?? true;
    is_searching_new = json['is_searching_new'] ?? false;
    created_at = json['created_at'] ?? '';
    last_seen = json['last_seen'] ?? '';
    user_UID = json['user_UID'] ?? '';
    useremail = json['useremail'] ?? '';
    username = json['username'] ?? '';
    userpass = json['userpass'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['blocked_list'] = blocked_list;
    data['friends_list'] = friends_list;
    data['is_online'] = is_online;
    data['is_searching_new'] = is_searching_new;
    data['created_at'] = created_at;
    data['last_seen'] = last_seen;
    data['user_UID'] = user_UID;
    data['useremail'] = useremail;
    data['username'] = username;
    data['userpass'] = userpass;

    return data;
  }
}
