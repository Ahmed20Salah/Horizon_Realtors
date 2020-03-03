import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Login) {
      yield Loading();

      var re = await login(event.user);
      try {
        if (re['status']) {
          yield Authenticated();
        } else {
          yield Error(re);
        }
      } catch (e) {
        print(e);
        
        yield Error({'message': 'Something went wrong!'});
      }
    }
  }
}
