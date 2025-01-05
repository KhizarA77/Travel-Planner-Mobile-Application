import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),),
        SizedBox(height: 10.h,),
        InkWell(
          onTap: () {
            // personal info page
          },
          child: Row(
            children: [
              Icon(Icons.person_pin, size: 30.sp,),
              SizedBox(width: 10.w, height: 50.h,),
              Text('Personal Information', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 20.sp, color: Colors.black,),
            ],
          ),
        ),
        const Divider(),
        InkWell(
          onTap: (){
            // change password page
          },
          child: Row(
            children: [
              Icon(Icons.lock, size: 30.sp,),
              SizedBox(width: 10.w, height: 50.h,),
              Text('Change Password', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 20.sp, color: Colors.black,),
            ],
          ),
        ),
        const Divider(),
        InkWell(
          onTap: (){
            // change password page
          },
          child: Row(
            children: [
              Icon(Icons.file_copy_sharp, size: 30.sp,),
              SizedBox(width: 10.w, height: 50.h,),
              Text('Taxes', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 20.sp, color: Colors.black,),
            ],
          ),
        ),
        const Divider(),
        SizedBox(height: 10.h,),
        Text('Bookings', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),

      ],
    );
  }
}