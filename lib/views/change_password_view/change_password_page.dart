import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/services/auth_service.dart';
import 'package:travelhive/widgets/login_widgets/text_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangePasswordPage extends StatelessWidget {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20.sp),
        color: Colors.white,
        child: Column(
          children: [
            CustomTextField(
                labelText: 'New Password',
                obscureText: true,
                controller: newPasswordController),
            CustomTextField(
                labelText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    String response = await AuthService()
                        .updatePassword(newPasswordController.text);
                    if (response == 'Success') {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.success(
                          message: "Password updated successfully",
                        ),
                      );
                        Navigator.pop(context);
                    }
                    else {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: response,
                        ),
                      );
                    }
                  } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: "An error occurred",
                        ),
                      );
                  }
                },
                child: Text('Change Password')),
          ],
        ),
      ),
    );
  }
}
