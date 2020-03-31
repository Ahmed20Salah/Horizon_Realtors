part of 'properties_bloc.dart';

abstract class PropertiesEvent extends Equatable {
  const PropertiesEvent();
}

class GetProperties extends PropertiesEvent {
  @override
  List<Object> get props => [];
}

class AddProperties extends PropertiesEvent {
  final Map map;
  AddProperties(this.map);

  @override
  List<Object> get props => [];
}
