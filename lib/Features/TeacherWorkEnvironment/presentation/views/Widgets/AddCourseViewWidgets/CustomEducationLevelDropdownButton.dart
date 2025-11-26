import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/locale_keys.dart';

class CustomEducationLevelDropdownButton extends StatefulWidget {
  const CustomEducationLevelDropdownButton(
      {super.key, required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  State<CustomEducationLevelDropdownButton> createState() =>
      _CustomEducationLevelDropdownButtonState();
}

class _CustomEducationLevelDropdownButtonState
    extends State<CustomEducationLevelDropdownButton> {
  List<String> items = [
    "1st Grade Primary",
    "2nd Grade Primary",
    "3rd Grade Primary",
    "4th Grade Primary",
    "5th Grade Primary",
    "6th Grade Primary",
    "1st Grade Preparatory",
    "2nd Grade Preparatory",
    "3rd Grade Preparatory",
    "1st Grade Secondary",
    "2nd Grade Secondary",
    "3rd Grade Secondary",
  ];
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: items,
      hintText: LocaleKeys.studentEducationLevel,
      onChanged: widget.onValueChange,
    );
  }
}
