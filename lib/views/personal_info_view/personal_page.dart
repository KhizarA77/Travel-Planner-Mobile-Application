import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';


class PersonalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserDataFailure) {
          return Center(
            child: Text('Failed to load user data: ${state.error}'),
          );
        } else if (state is UserDataSuccess) {
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal info', style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.h,),
                  Text('Legal name', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  Text(state.userData.name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
                  const Divider(),
                  Text('Email', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  Text(state.userData.email, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}