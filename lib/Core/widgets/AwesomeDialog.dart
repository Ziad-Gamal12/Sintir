// ignore_for_file: non_constant_identifier_names, file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

AwesomeDialog errordialog(
  context,
  String? error, {
  void Function()? btnOkOnPress,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: LocaleKeys.snackError, // "خطأ"
    desc: error,
    btnOkText: LocaleKeys.confirm, // "حسنا"
    btnOkOnPress: btnOkOnPress,
    btnOkColor: Colors.red,
  );
}

AwesomeDialog successdialog({
  required context,
  required String? SuccessMessage,
  required void Function()? btnOkOnPress,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: LocaleKeys.snackSuccess, // "نجاح"
    desc: SuccessMessage,
    btnOkText: LocaleKeys.confirm, // "حسنا"
    btnOkOnPress: btnOkOnPress,
    btnOkColor: Colors.green,
  );
}

AwesomeDialog warningdialog(
  context,
  String? WarningMessage,
  void Function()? btnOkOnPress,
) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: LocaleKeys.snackWarning, // "تحذير"
    desc: WarningMessage,
    btnOkText: LocaleKeys.confirm, // "حسنا"
    btnOkOnPress: btnOkOnPress,
    btnOkColor: Colors.yellow.shade800,
  );
}

AwesomeDialog infodialog({
  required context,
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
    title: LocaleKeys.snackInfo, // "معلومات"
    desc: InfoMessage,
    btnOkOnPress: btnOkOnPress,
    btnOkText: btnOkText ?? LocaleKeys.confirm,
    btnCancelText: btnCancelText,
    btnCancelOnPress: btnCancelOnPress,
    btnCancelColor: Colors.blue,
    btnOkColor: Colors.blue,
  );
}
