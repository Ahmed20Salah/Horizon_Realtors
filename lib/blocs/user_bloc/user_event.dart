part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class Login extends UserEvent {
  final Map user;
  Login(this.user);

  @override
  List<Object> get props => null;
}

class Register extends UserEvent {
  final Map user;
  Register(this.user);

  @override
  List<Object> get props => [];
}

class Checking extends UserEvent {
  @override
  List<Object> get props => [];
}

class ForgetPassword extends UserEvent {
  const ForgetPassword();

  @override
  List<Object> get props => [];
}

class GetAgencies extends UserEvent {
  @override
  List<Object> get props => [];
}

class Search extends UserEvent {
  final String word;
  Search(this.word);
  @override
  List<Object> get props => [];
}
