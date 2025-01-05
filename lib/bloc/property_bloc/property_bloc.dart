


import 'package:bloc/bloc.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/models/property.dart';
import 'package:travelhive/services/property_collection_service.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {

  PropertyBloc() : super(PropertyInitial()) {
    on<FetchProperties>(_onPropertyFetch);
  }

  Future<void> _onPropertyFetch(FetchProperties event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      final List<Property> response = await PropertyCollectionService().getProperties();
      if (response.isEmpty) {
        emit(PropertyFailure(error: 'No properties found'));
        return;
      }
      emit(PropertySuccess(properties: response));
    } catch (error) {
      emit(PropertyFailure(error: error.toString()));
    }
  }

}