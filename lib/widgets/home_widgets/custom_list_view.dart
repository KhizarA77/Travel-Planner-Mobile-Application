import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/widgets/home_widgets/listing_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PropertyFailure) {
          return Center(
            child: Text('Failed to load properties: ${state.error}'),
          );
        } else if (state is PropertySuccess) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return ListingCard(property: property);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}