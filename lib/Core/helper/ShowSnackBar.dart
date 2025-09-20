// ignore_for_file: file_names, non_constant_identifier_names

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

ShowSnackBar({
  required BuildContext context,
  required Widget child,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: child,
    ),
  );
}

void ShowErrorSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "خطأ",
        message: message,
        contentType: ContentType.failure,
      ),
    ),
  );
}

void showWarningSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "تحذير",
        message: message,
        contentType: ContentType.warning,
      ),
    ),
  );
}

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "نجاح",
        message: message,
        contentType: ContentType.success,
      ),
    ),
  );
}
