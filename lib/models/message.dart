/// Message model
class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  ///to whom the msg is sent
  late final String toId;

  /// what is the message content
  late final String msg;

  /// when the message is read
  late final String read;

  /// who sent the msg
  late final String fromId;

  /// msg sent time
  late final String sent;

  /// type of the msg {img or text}
  late final Type type;

  /// convert the json data to Message Model data
  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
  }

  /// convert Message model to Json
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum Type { text, image }
