import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizon_realtors/repository/agency_repo.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  @override
  PropertiesState get initialState => PropertiesInitial();

  @override
  Stream<PropertiesState> mapEventToState(
    PropertiesEvent event,
  ) async* {
    AgencyRepository _agencyRepo = AgencyRepository();

    if (event is GetProperties) {
      print(event);
      yield Loading();
      var re = await _agencyRepo.getProperties();
      if (re['status']) {
        yield HaveProperties();
      } else {
        yield Error(re['errors']);
      }
    }
  }
}
