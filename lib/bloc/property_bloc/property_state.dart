import 'package:travelhive/models/property.dart';

abstract class PropertyState {}


class PropertyInitial extends PropertyState {}
class PropertyLoading extends PropertyState {}

class PropertyFailure extends PropertyState {
  final String error;

  PropertyFailure({required this.error});

  @override
  String toString() => 'PropertyFailure { error: $error }';
}

class PropertySuccess extends PropertyState {
  final List<Property> properties;

  PropertySuccess({required this.properties});

  @override
  String toString() => 'PropertySuccess { properties: $properties }';
}