// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

ShowSnackBar(
    {required BuildContext context,
    required Widget child,
    required Color backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: child,
  ));
}
