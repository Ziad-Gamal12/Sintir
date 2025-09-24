// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Cusstomcard extends StatelessWidget {
  const Cusstomcard(
      {super.key, required this.child, required this.backgroundColor});
  final Widget child;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: backgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: child,
        ));
  }
}
