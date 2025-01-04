// register_page.dart

import 'package:flutter/material.dart';
import 'package:travelhive/bloc/register_bloc/register_bloc.dart';
import 'package:travelhive/widgets/login_widgets/text_fields.dart';
import 'package:travelhive/widgets/register_widgets/register_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    Color color = const Color.fromARGB(255, 255, 255, 255);
    
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: color,
        ),
        backgroundColor: color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(labelText: 'Name', obscureText: false, controller: nameController,),
              CustomTextField(labelText: 'Email', obscureText: false, controller: emailController,),
              CustomTextField(labelText: 'Password', obscureText: true, controller: passwordController,),
              CustomTextField(labelText: 'Confirm Password', obscureText: true, controller: confirmPasswordController,),
              RegisterButton(emailController: emailController, passwordController: passwordController, confirmPasswordController: confirmPasswordController, nameController: nameController,),
            ],
          ),
        ),
      ),
    );
  }


}