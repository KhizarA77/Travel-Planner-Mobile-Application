import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';



class BookingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is UserDataFailure) {
          return Center(
            child: Text('Failed to load user data: ${state.error}'),
          );
        }
        else if (state is UserDataSuccess) {
            return Scaffold(
              appBar: AppBar(),
              body: Expanded(
                child: ListView.builder(
                itemCount: state.userData.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.userData.bookings[index]!;
                  return ListTile(
                  title: Text(booking.propertyName),
                  subtitle: Text(booking.propertyDescription),
                  onTap: () {
                    // Handle booking tap
                  },
                  );
                },
                ),
              ),
            );
        }
        else {
          return Container();
        }
    });


  }


}