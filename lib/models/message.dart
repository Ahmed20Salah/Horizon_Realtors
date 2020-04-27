class Message {
  int id;
  String message;
  MessageType type;
  Message.fromJson(map, type) {
    this.id = map['id'];
    this.message = map['body'];
    this.type = type;
  }
}

enum MessageType { Send, Receive }
