part of 'agency_bloc.dart';

abstract class AgencyEvent extends Equatable {
  const AgencyEvent();
}

class GetHomeData extends AgencyEvent {
  @override
  List<Object> get props => [];
}
