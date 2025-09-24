// ignore_for_file: file_names, use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  BorderRadiusGeometry? borderRadius;
  BorderSide? side;
  Widget? child;
  Custombutton({
    Key? key,
    required this.text,
    this.borderRadius,
    this.child,
    this.side,
    required this.color,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        side: side ?? BorderSide.none,
        borderRadius:
            borderRadius == null ? BorderRadius.circular(16) : borderRadius!,
      ),
      onPressed: onPressed,
      color: color,
      child: child ??
          Text(text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bold16Auto.copyWith(color: textColor)),
    );
  }
}
