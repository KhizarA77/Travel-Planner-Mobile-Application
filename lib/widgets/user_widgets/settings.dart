import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/services/auth_service.dart';
import 'package:travelhive/views/change_password_view/change_password_page.dart';
import 'package:travelhive/views/login_view/login_page.dart';
import 'package:travelhive/views/personal_info_view/personal_page.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PersonalPage()));
          },
          child: Row(
            children: [
              Icon(
                Icons.person_pin,
                size: 30.sp,
              ),
              SizedBox(
                width: 10.w,
                height: 50.h,
              ),
              Text(
                'Personal Information',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 20.sp,
                color: Colors.black,
              ),
            ],
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()));
          },
          child: Row(
            children: [
              Icon(
                Icons.lock,
                size: 30.sp,
              ),
              SizedBox(
                width: 10.w,
                height: 50.h,
              ),
              Text(
                'Change Password',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 20.sp,
                color: Colors.black,
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Bookings',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: TextButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                  (_) => false,
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
