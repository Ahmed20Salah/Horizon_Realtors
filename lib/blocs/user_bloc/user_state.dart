part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class Unauthenticated extends UserState {
  @override
  List<Object> get props => [];
}

class Authenticated extends UserState {
  @override
  List<Object> get props => [];
}

class Loading extends UserState {
  @override
  List<Object> get props => [];
}

class Error extends UserState {
 final Map error;
  Error(this.error);
  @override
  List<Object> get props => [];
}
