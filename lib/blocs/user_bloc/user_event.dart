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

class ForgetPassword extends UserEvent {
  const ForgetPassword();

  @override
  List<Object> get props => null;
}
