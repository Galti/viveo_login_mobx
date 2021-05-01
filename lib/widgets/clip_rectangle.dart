import 'package:flutter/material.dart';
import 'package:viveo_login_mobx/constants/dimens.dart';

class ClipRectangle extends StatelessWidget {
  final Widget child;
  final double radius;

  const ClipRectangle({
    Key? key,
    required this.child,
    this.radius = Dimens.curvingSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: child,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
