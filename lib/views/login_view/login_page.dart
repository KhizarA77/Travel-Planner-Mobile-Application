import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/views/register_view/register_page.dart';
import 'package:travelhive/widgets/login_widgets/facebook_button.dart';
import 'package:travelhive/widgets/login_widgets/forget_button.dart';
import 'package:travelhive/widgets/login_widgets/google_button.dart';
import 'package:travelhive/widgets/login_widgets/login_button.dart';
import 'package:travelhive/widgets/login_widgets/text_fields.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    Color color = const Color.fromARGB(255, 255, 255, 255);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: color,
      ),
      backgroundColor: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomTextField(labelText: 'Email', obscureText: false, controller: emailController,),
          CustomTextField(labelText: 'Password', obscureText: true, controller: passwordController,),
          ForgetButton(emailController: emailController),
          LoginButton(emailController: emailController, passwordController: passwordController,),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?', style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Register', style: TextStyle(color: Color.fromARGB(255, 38, 0, 255), fontSize: 15.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          const Text('OR', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5.h),
          const GoogleButton(),
          const FacebookButton(),
        ],
      ),
    );
  }


}