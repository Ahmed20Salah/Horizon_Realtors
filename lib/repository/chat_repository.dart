import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/models/chat.dart';
import 'package:horizon_realtors/models/message.dart';
import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/utilts/constant.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatRepository {
  static final _obj = ChatRepository._internal();

  ChatRepository._internal();

  factory ChatRepository() {
    return _obj;
  }

  List<Chat> allChats = [];

  int unread = 0;
  Constant _constant = Constant();
  UserRepository _userRepository = UserRepository();
  var chatBloc;

  void getAllChats(bloc) async {
    Pusher.init('b20c5969416dc6417da6',
        PusherOptions(cluster: 'eu', encrypted: true, activityTimeout: 30000),
        enableLogging: false);
    Pusher.connect(onConnectionStateChange: (con) {
      print(con.currentState);
    }, onError: (error) {
      print(error);
    });
    print('chats');
//    try {
    var response = await http.get('${_constant.url}/api/chat/all_chats/1');
    print(response.body);
    var converted = jsonDecode(response.body);
    for (var item in converted['data']) {
      Map<String, dynamic> _user;

      // print(item['id']);
      listenFun(roomId: item['id'], bloc: bloc);

      if (item['user1_id'] == 1) {
        _user = item['user2_data'];
      } else {
        _user = item['user1_data'];
      }

      _user = {
        "id": 1,
        "name": "test",
        "email": "test@test.com",
        "phone": "01000000",
        "email_verified_at": null,
        "status": 1,
        "created_at": "2020-03-24 20:18:12",
        "updated_at": "2020-04-14 12:40:39",
        "user_img": null
      };
      unread += item['unread_chat'].length;
      allChats.add(Chat.fromMap(item, _user));
    }
    // print(unread);
//    } catch (e) {
//      print(e);
//    }
  }

  void sendMessages(Message message, id) async {
    print('send message');
    try {
      var response = await http.post(
          '${_constant.url}/api/chat/send_message?body=${message.message}&room_id=$id&user_id=1');
      print(response.body);
      var converted = jsonDecode(response.body);
      print(converted);
    } catch (e) {
      print(e);
    }
  }

  void listenFun({roomId, bloc}) async {
    await Pusher.subscribe('room.$roomId').then((val) async {
      val.bind('new_message', (va) {
        var converted = jsonDecode(va.data);
        allChats.forEach((element) {
          if (element.roomId == converted['room_id']) {
            element.unreadMessages.add(Message.fromJson(
                {'id': null, "body": converted['message']},
                MessageType.Receive));
            unread++;
            bloc.add(ReceiveMessage());
          }
        });
      });
    });
  }

  search(word) {
    List<Chat> filterd = [];
    allChats.forEach((element) {
      if (element.user.name.contains(word)) {
        filterd.add(element);
      }
    });

    return filterd;
  }
}
