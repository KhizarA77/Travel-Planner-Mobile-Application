import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  const CustomTextField({Key? key, required this.labelText, required this.obscureText, required this.controller}) : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}


class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        // color: Colors.blueGrey[50],
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
        ),
        obscureText: widget.obscureText,
      ),
    );
  }
}