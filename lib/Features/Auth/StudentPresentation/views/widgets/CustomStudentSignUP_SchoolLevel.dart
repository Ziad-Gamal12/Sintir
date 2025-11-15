// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class CustomstudentsignupSchoollevel extends StatefulWidget {
  const CustomstudentsignupSchoollevel({
    super.key,
  });
  @override
  State<CustomstudentsignupSchoollevel> createState() =>
      CustomstudentsignupSchoollevelState();
}

class CustomstudentsignupSchoollevelState
    extends State<CustomstudentsignupSchoollevel> {
  String? optionItemSelected;
  List<String> items = [
    "الصف الأول الأبتدائى",
    "الصف الثانى الأبتدائى",
    "الصف الثالث الأبتدائى",
    "الصف الرابع الأبتدائى",
    "الصف الخامس الأبتدائى",
    "الصف السادس الأبتدائى",
    "الصف الأول الأعدادى",
    "الصف الثانى الأعدادى",
    "الصف الثالث الأعدادى",
    "الصف الأول الثانوى",
    "الصف الثانى الثانوى",
    "الصف الثالث الثانوى",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
        items: items,
        hintText: "السنة الدراسية",
        onChanged: (val) {
          optionItemSelected = val;
          context.read<UserEntity>().studentExtraDataEntity?.educationLevel =
              optionItemSelected ?? "";
          setState(() {});
        });
  }
}
