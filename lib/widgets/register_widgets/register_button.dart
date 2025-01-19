// register_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/services/auth_service.dart';
import 'package:travelhive/views/verification_view/verification_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travelhive/bloc/register_bloc/bloc.dart'; // Import your RegisterBloc

class RegisterButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;

  const RegisterButton(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30.0.sp), boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ]),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.error,
              ),
            );
          } else if (state is RegisterSuccess) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerificationPage()),
            );
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0.sp),
              ),
            ),
            onPressed: state is RegisterLoading
                ? null
                : () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();
                    final name = nameController.text.trim();
                    final userdetails = UserRegisterModel(email: email, displayName: name);
                    if (password == confirmPassword) {
                      context.read<RegisterBloc>().add(RegisterButtonPressed(user: userdetails, password: password));
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: "Passwords do not match",
                        ),
                      );
                    }
                  },
            child: state is RegisterLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  )
                : Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
          );
        },
      ),
    );
  }
}
