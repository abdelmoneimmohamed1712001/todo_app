import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String hint;
  Validator? validator;
  TextInputType? keyboardType;
  bool isSecureText;
  Widget? suffixIcon;
  TextEditingController? controller;
  Function(dynamic value)? onChanged;
  String? initialValue;

  CustomTextFormField(
      {required this.hint,
        this.validator,
        this.keyboardType,
        this.isSecureText = false,
        this.suffixIcon,
        this.controller,
        this.onChanged ,
        this.initialValue,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: isSecureText,
        keyboardType: keyboardType,
        validator: validator,
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          fillColor: Colors.white,
          filled: true,


          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff707070), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff707070), width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.red, width: 2)),

        ),

      ),
    );
  }
}
