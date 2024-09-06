// ignore_for_file: non_constant_identifier_names, file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog errordialog(context, String? error) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'خطأ',
      desc: error,
      btnOkOnPress: () {},
      btnOkColor: Colors.red);
}

AwesomeDialog successdialog(
    {required context,
    required String? SuccessMessage,
    required void Function()? btnOkOnPress}) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'نجاح',
      desc: SuccessMessage,
      btnOkOnPress: btnOkOnPress,
      btnOkColor: Colors.green);
}

AwesomeDialog warningdialog(context, String? WarningMessage) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'تحذير',
      desc: WarningMessage,
      btnOkOnPress: () {},
      btnOkColor: Colors.yellow);
}

AwesomeDialog infodialog({
  context,
  String? InfoMessage,
  String? btnOkText,
  void Function()? btnOkOnPress,
  void Function()? btnCancelOnPress,
  String? btnCancelText,
}) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'معلومات',
      desc: InfoMessage,
      btnOkOnPress: btnOkOnPress,
      btnOkText: btnOkText,
      btnCancelText: btnCancelText,
      btnCancelOnPress: btnCancelOnPress,
      btnCancelColor: Colors.blue,
      btnOkColor: Colors.blue);
}
