// forget_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travelhive/services/auth_service.dart';

class ForgetButton extends StatelessWidget {
  final TextEditingController emailController;
  const ForgetButton({Key? key, required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final String _email = emailController.text.trim();
        if (_email.isEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "Email cannot be empty",
            ),
          );
          return;
        } 
        String response = await AuthService()
            .resetPassword(email: _email);
        if (response == 'A password reset link has been sent to your email') {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: "A password reset link has been sent to your email",
            ),
          );
        } else {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
        }
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
            color: Color.fromARGB(255, 38, 0, 255),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
    );
  }
}
