import 'package:travelhive/models/user_model.dart';

abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final UserModel userData;

  UserDataSuccess({required this.userData});

  @override
  String toString() => 'UserDataSuccess { userData: $userData }';
}

class UserDataFailure extends UserDataState {
  final String error;

  UserDataFailure({required this.error});

  @override
  String toString() => 'UserDataFailure { error: $error }';
}