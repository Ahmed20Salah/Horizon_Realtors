import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizon_realtors/repository/properties_repo.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  @override
  PropertiesState get initialState => PropertiesInitial();

  @override
  Stream<PropertiesState> mapEventToState(
    PropertiesEvent event,
  ) async* {
    PropertiesRepository _properiesRepo = PropertiesRepository();

    if (event is GetProperties) {
      print(event);
      yield Loading();
      var re = await _properiesRepo.getProperties();
      if (re['status']) {
        yield HaveProperties();
      } else {
        yield Error(re['errors']);
      }
    } else if (event is AddProperties) {
      yield Loading();
      var re = await _properiesRepo.addProperety(event.map);
      if (re['status']) {
        yield AddedProperty();
      } else {
        yield Error(re['message']);
      }
    }
  }
}
