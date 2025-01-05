import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/user_data_bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/user_data_state.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

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
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${state.userData.name.split(' ')[0]} 👋',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Explore the world',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ClipOval(
                child: Image.network(
                    state.userData.photoUrl.isNotEmpty ? state.userData.photoUrl : FirebaseAuth.instance.currentUser!.photoURL ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLMI5YxZE03Vnj-s-sth2_JxlPd30Zy7yEGg&s',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }

      } 
    );

    // return Row(
    //   children: [
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Hi, David 👋',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.black,
    //           ),
    //         ),
    //         Text(
    //           'Explore the world',
    //           style: TextStyle(
    //             fontSize: 14,
    //             color: Colors.grey,
    //           ),
    //         ),
    //       ],
    //     ),
    //     const Spacer(),
    //     ClipOval(
    //       child: Image.network(
    //         'http://192.168.100.164:3000/uploads/390e6682-e4f6-4332-8ee9-67428760447e.png',
    //         width: 100,
    //         height: 100,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ],
    // );
  }
}
