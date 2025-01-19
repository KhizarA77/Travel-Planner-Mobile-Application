// verification_page.dart

import 'package:flutter/material.dart';



class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification'),),
      body: Center(
        child: Text('An email has been sent to your email address. Please verify your email to complete the registration.', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
    );
  }
}