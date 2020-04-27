part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class Loading extends ChatState {
  @override
  List<Object> get props => [];
}

class Error extends ChatState {
  @override
  List<Object> get props => [];
}

class HavemainChats extends ChatState {
  @override
  List<Object> get props => [];
}

class ReceivedMessage extends ChatState {
  @override
  List<Object> get props => [];
}

class Searching extends ChatState {
  @override
  List<Object> get props => [];
}

class Found extends ChatState {
  final List<Chat> filtred;
  Found(this.filtred);
  @override
  List<Object> get props => [];
}
class Sent extends ChatState {
  @override
  List<Object> get props => [];
}