class NewConnectedChatUser {
  NewConnectedChatUser({
    required this.is_online,
    required this.is_searching_new,
    required this.last_seen,
    required this.user_UID,
    required this.username,
  });

  late bool is_online;
  late bool is_searching_new;
  late String last_seen;
  late String user_UID;
  late String username;

  NewConnectedChatUser.fromJson(Map<String, dynamic> json) {
    is_online = json['is_online'] ?? true;
    is_searching_new = json['is_searching_new'] ?? false;
    last_seen = json['last_seen'] ?? '';
    user_UID = json['user_UID'] ?? '';
    username = json['username'] ?? '';
  }
}
