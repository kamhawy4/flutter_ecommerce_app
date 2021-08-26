import 'package:flu/screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;

  final Function onClick;

  _errorMessage(String str) {
    switch (hint) {
      case 'Enter Your Name':
        return 'Name is Empty !';
      case 'Enter Your Email':
        return 'Email is Empty !';
      case 'Enter Your Password':
        return 'Password is Empty !';
    }
  }

  CustomTextField(
      {required this.onClick, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return _errorMessage(hint);
          }
          onSaved:
          onClick(value);
        },
        obscureText: hint == 'Enter Your Password' ? true : false,
        cursorColor: KmainColor,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: KmainColor),
            filled: true,
            fillColor: KSecondaryColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
