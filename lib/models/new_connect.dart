/// new connected user Model
class NewConnectedChatUser {
  NewConnectedChatUser({
    required this.is_online,
    required this.is_searching_new,
    required this.last_seen,
    required this.user_UID,
    required this.username,
  });

  /// user is online?
  late bool is_online;

  ///whether searching new
  late bool is_searching_new;

  ///last seen of the user
  late String last_seen;

  /// unique id of the user
  late String user_UID;

  /// name of the user
  late String username;

  /// get the User model from json
  NewConnectedChatUser.fromJson(Map<String, dynamic> json) {
    is_online = json['is_online'] ?? true;
    is_searching_new = json['is_searching_new'] ?? false;
    last_seen = json['last_seen'] ?? '';
    user_UID = json['user_UID'] ?? '';
    username = json['username'] ?? '';
  }
}
