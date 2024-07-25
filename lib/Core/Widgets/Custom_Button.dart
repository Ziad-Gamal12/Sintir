import 'package:flutter/material.dart';

import 'package:sintir/constant.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onTap;
  final BorderRadiusGeometry borderradius;
  final double width;
  final Color? color;
  const CustomButton(
      {Key? key,
      required this.widget,
      this.width = double.infinity,
      this.color = KMainColor,
      required this.onTap,
      required this.borderradius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: borderradius),
        minWidth: double.infinity,
        height: 54,
        color: color,
        onPressed: onTap,
        child: widget);
  }
}
