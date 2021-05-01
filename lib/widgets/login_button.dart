import 'package:flutter/material.dart';
import 'package:viveo_login_mobx/constants/app_colors.dart';
import 'package:viveo_login_mobx/constants/dimens.dart';

import 'clip_rectangle.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRectangle(
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
          child: Container(
            height: Dimens.loginElementsHeight,
            child: Center(
              child: Text(text, style: TextStyle(color: AppColors.white)),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
