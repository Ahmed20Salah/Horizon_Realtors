import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Login) {
      yield Loading();

      var re = await _userRepository.login(event.user);

      if (re['status']) {
        yield Authenticated();
      } else {
        yield Error(re);
      }
    } else if (event is Register) {
      print('register');
      yield Loading();
      var re = await _userRepository.register(event.user);
      if (re['status']) {
        yield Authenticated();
      } else {
        yield Error(re);
      }
    } else if (event is Checking) {
      yield Loading();
      var re = await _userRepository.checkAuth();
      if (re) {
        yield Authenticated();
      } else {

        yield Unauthenticated();
      }
    } else if (event is Search) {
      yield Searching();

      if (_userRepository.agenies.length == 0) {
        _userRepository.getAgencies().then(
          (value) async* {
            var re = _userRepository.search(event.word);
            
            if (re.length > 0) {
              yield Founded(re);
            }
          },
        );
      } else {
        var re = _userRepository.search(event.word);
        if (re.length > 0) {
          yield Founded(re);
        }
      }
    }
  }
}
