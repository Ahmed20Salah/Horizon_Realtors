import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  @override
  AgencyState get initialState => AgencyInitial();

  @override
  Stream<AgencyState> mapEventToState(
    AgencyEvent event,
  ) async* {
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
