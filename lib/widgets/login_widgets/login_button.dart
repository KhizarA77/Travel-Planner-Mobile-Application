import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travelhive/services/auth_service.dart';
import 'package:travelhive/views/home_view/home_page.dart';



class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginButton({Key? key, required this.emailController, required this.passwordController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0.sp),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();
            String response = await AuthService().signInWithEmailPassword(email:email, password:password);
            if(response == 'Success') {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
            } else {
              showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: response,
                        ),
                      );
            }
        },
        child: const Text('Login', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
      ),
    );
  }

}