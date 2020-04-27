part of 'agency_bloc.dart';

abstract class AgencyState extends Equatable {
  const AgencyState();
}

class AgencyInitial extends AgencyState {
  @override
  List<Object> get props => [];
}

class AgencyLoading extends AgencyState {
  @override
  List<Object> get props => [];
}

class AgencyError extends AgencyState {
  final String error;
  AgencyError(this.error);
  @override
  List<Object> get props => [];
}

class HaveHomeData extends AgencyState {
  @override
  List<Object> get props => [];
}


