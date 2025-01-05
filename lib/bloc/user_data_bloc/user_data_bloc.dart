import 'package:bloc/bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/user_data_event.dart';
import 'package:travelhive/bloc/user_data_bloc/user_data_state.dart';
import 'package:travelhive/services/user_collection_service.dart';


class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {

  UserDataBloc() : super(UserDataInitial()) {
    on<UserDataLoad>(_onUserDataLoad);
  }

Future<void> _onUserDataLoad(UserDataLoad event, Emitter<UserDataState> emit) async {
  emit(UserDataLoading());
  try {
    final response = await UserCollectionService().getUserData(event.userId);
    emit(UserDataSuccess(userData: response));
  } catch (error) {
    emit(UserDataFailure(error: error.toString()));
  }
}
  
}

