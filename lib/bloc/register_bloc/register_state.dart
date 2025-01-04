abstract class RegisterState {}


final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}
final class RegisterSuccess extends RegisterState {}
final class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});

  @override
  String toString() => 'RegisterFailure { error: $error }';
}