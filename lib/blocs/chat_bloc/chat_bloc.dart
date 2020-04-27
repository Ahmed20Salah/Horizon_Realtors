import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/models/chat.dart';
import 'package:horizon_realtors/models/message.dart';
import 'package:horizon_realtors/repository/chat_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  // listenFun() async {
  //   await Pusher.subscribe('room.5').then((val) async {
  //     val.bind('new_message', (va) {
  //       print(va.data);
  //       print(va.channel);
  //       print('this from bloc');
  //       this.add(ReceiveMessage(va));
  //     });
  //   });
  // }


  @override
  ChatState get initialState => ChatInitial();
  ChatRepository _chatRepository = ChatRepository();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    print('$event this from bloc');
    if (event is GetAllChats) {
       _chatRepository.getAllChats(event.chatBloc);
    } else if (event is SendMessage) {
      _chatRepository.sendMessages(event.message, event.id);
      yield Sent();
    } else if (event is Search) {
      var re = await _chatRepository.search(event.word).then((val) async* {
        yield Found(val);
      });
    } else if (event is Stoped) {
      yield ChatInitial();
    } else if (event is ReceiveMessage) {
      print('yeild');
      yield ChatInitial();
      yield ReceivedMessage();
    }
  }
}
