import 'package:flutter/material.dart';
import 'package:viveo_login_mobx/constants/app_colors.dart';

class LoginTextField extends StatelessWidget {
  final void Function(String) onChanged;
  final String hintText;
  final String? errorText;
  final bool isObscured;

  const LoginTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.errorText = '',
    this.isObscured = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isObscured,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(color: AppColors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      style: TextStyle(color: AppColors.red),
    );
  }
}
