part of 'properties_bloc.dart';

abstract class PropertiesState extends Equatable {
  const PropertiesState();
}

class PropertiesInitial extends PropertiesState {
  @override
  List<Object> get props => [];
}

class HaveProperties extends PropertiesState {
  @override
  List<Object> get props => [];
}

class Error extends PropertiesState {
 final  String  errors;
 Error(this.errors);
   @override
  List<Object> get props => [];
}

class Loading extends PropertiesState {
  @override
  List<Object> get props => [];
}
class AddedProperty extends PropertiesState {
  @override
  List<Object> get props => [];
}
