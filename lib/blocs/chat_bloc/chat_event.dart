part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class GetAllChats extends ChatEvent {
  final ChatBloc chatBloc;
  GetAllChats(this.chatBloc);
  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final Message message;
  final int id;
  SendMessage(this.message, this.id);
  @override
  List<Object> get props => [];
}

class ReceiveMessage extends ChatEvent {

  @override
  List<Object> get props => [];
}

class NewRoom extends ChatEvent {
  @override
  List<Object> get props => [];
}
class Stoped extends ChatEvent {
  @override
  List<Object> get props => [];
}

class Search extends ChatEvent {
  final String word;
  Search(this.word);
  @override
  List<Object> get props => [];
}
