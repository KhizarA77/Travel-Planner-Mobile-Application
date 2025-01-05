import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/widgets/user_widgets/profile_card.dart';
import 'package:travelhive/widgets/user_widgets/settings.dart';


class ProfileContainer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return Container(

      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top:40.h, left: 20.w, right: 10.w),
      color: Colors.white,
      child: Column(
        children: [
          ProfileCard(),
          SizedBox(
            height: 50.h,
          ),
          Settings()
        ],
      ),


    );


  }

}