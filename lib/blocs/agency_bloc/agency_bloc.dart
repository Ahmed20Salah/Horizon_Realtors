import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizon_realtors/repository/agency_repo.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  @override
  AgencyState get initialState => AgencyInitial();

  @override
  Stream<AgencyState> mapEventToState(
    AgencyEvent event,
  ) async* {
    AgencyRepository _agencyRepo = AgencyRepository();
    // if (event is GetProperties) {
    //   var re = await _agencyRepo.getProperties();
    //   if (re['status']) {
    //     yield Ha();
    //   } else {
    //     yield Error(re['errors']);
    //   }
    // }
  }
}
