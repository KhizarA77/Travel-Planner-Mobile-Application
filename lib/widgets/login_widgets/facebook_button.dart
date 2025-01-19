//facebook_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sign_in_button/sign_in_button.dart';
import 'package:sign_button/sign_button.dart';
import 'package:travelhive/services/auth_service.dart';
import 'package:travelhive/views/bottom_nav_view/bottom_nav.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 50.h,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(30.0.sp),
      //   boxShadow: [
      //     BoxShadow(
      //       color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 7,
      //       offset: const Offset(0, 3), // changes position of shadow
      //     ),
      //   ]
      // ),
      child: SignInButton.mini(buttonType: ButtonType.facebook, onPressed: () async {
        String response = await AuthService().continueWithFacebook();
        if (response == 'Success') {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNav()), (_) => false);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
          ));
        }
      }),
    );
  }
}