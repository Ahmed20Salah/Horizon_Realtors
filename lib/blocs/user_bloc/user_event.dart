part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

abstract class Login extends Equatable {
  const Login();
}

abstract class ForgetPassword extends Equatable {
  const ForgetPassword();
}
