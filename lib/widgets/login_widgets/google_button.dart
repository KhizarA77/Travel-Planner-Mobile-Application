import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:travelhive/services/auth_service.dart';


class GoogleButton extends StatelessWidget {

  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: SignInButton(Buttons.google, text: "Continue With Google", onPressed: () async {
        String response = await AuthService().continueWithGoogle();
        if (response == 'Success') {
          print('object');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
          ));
        }
      }),
    );
  }


}
