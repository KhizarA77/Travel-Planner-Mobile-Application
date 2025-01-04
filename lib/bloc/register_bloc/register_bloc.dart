import 'package:bloc/bloc.dart';
import 'package:travelhive/bloc/register_bloc/register_event.dart';
import 'package:travelhive/bloc/register_bloc/register_state.dart';
import 'package:travelhive/services/auth_service.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }


  Future<void> _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await AuthService().registerWithEmailPassword(
        user: event.user,
        password: event.password,
      );
      if (response == 'Verification email sent') {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(error: response));
      }
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }

}

