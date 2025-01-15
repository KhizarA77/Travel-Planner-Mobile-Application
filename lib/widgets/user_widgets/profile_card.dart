import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';
import 'package:travelhive/views/card_view/card_page.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(builder: (context, state) {
      if (state is UserDataLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UserDataFailure) {
        return Center(
          child: Text('Failed to load user data: ${state.error}'),
        );
      } else if (state is UserDataSuccess) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Profile',
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // IconButton(
                //     onPressed: () {
                //       // show notifications
                //     },
                //     icon: Icon(
                //       Icons.notifications_none,
                //       size: 25.sp,
                //     color: Colors.black,
                //     )),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<UserDataBloc>(context),
                        child: CardPage(name: state.userData.name.split(' ')[0]),
                      ),
                    ));
              },
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      state.userData.photoUrl.isNotEmpty
                          ? state.userData.photoUrl
                          : FirebaseAuth.instance.currentUser!.photoURL ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLMI5YxZE03Vnj-s-sth2_JxlPd30Zy7yEGg&s',
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userData.name.split(' ')[0],
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'View Profile',
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
