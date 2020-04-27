import 'package:horizon_realtors/models/message.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/repository/user_repo.dart';

class Chat {
  int roomId;
  User user;
  Post post;
  List<Message> messages;
  List<Message> unreadMessages;

  UserRepository _userRepository = UserRepository();

  Chat.fromMap(map, usermap) {
    this.roomId = map['id'];
    this.user = User.fromMap(usermap);
    this.post =
        map['chat_post'] == null ? null : Post.fromMap(map['chat_post']);
    this.messages = [];
    for (var item in map['chat']) {
      
      var type = item['user_id'] == _userRepository.user.id
          ? MessageType.Send
          : MessageType.Receive;
      this.messages.add(Message.fromJson(item, type));
    }
    this.unreadMessages = [];
    for (var item in map['unread_chat']) {
      var type =
          item['user_id'] == user.id ? MessageType.Send : MessageType.Receive;
      this.unreadMessages.add(Message.fromJson(item, type));
    }
  }
}
