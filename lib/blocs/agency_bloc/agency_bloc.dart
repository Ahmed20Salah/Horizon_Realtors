import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizon_realtors/repository/properties_repo.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  @override
  AgencyState get initialState => AgencyInitial();
  var _properitesrepo = PropertiesRepository();
  @override
  Stream<AgencyState> mapEventToState(
    AgencyEvent event,
  ) async* {
    if (event is GetHomeData) {
      var re = await _properitesrepo.getAgencyHome();
      yield AgencyLoading();
      if (re['status']) {
        yield HaveHomeData();
      } else {
        yield AgencyError(re['errors']);
      }
    }
  }
}
