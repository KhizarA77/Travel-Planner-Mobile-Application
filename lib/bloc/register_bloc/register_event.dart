import 'package:travelhive/services/auth_service.dart';

abstract class RegisterEvent {}


class RegisterButtonPressed extends RegisterEvent {
  final UserRegisterModel user;
  final String password;

  RegisterButtonPressed({
    required this.user,
    required this.password,
  });

  @override
  String toString() => 'RegisterButtonPressed { email: ${user.email}, password: $password }';
}