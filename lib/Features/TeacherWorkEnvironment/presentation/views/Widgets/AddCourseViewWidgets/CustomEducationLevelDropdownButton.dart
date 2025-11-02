import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';

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
    "الثالث الثانوي",
    "الثاني الثانوي",
    "الاول الثانوي",
    "الثالث الأعدادي",
    "الثاني الأعدادي",
    "الاول الأعدادي",
    "السادس الأبتدائي",
    "الخامس الأبتدائي",
    "الرابع الأبتدائي",
    "الثالث الأبتدائي",
    "الثاني الأبتدائي",
    "الاول الأبتدائي",
    "أخرى"
  ];
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: items,
      hintText: "المستوى التعليمي",
      onChanged: widget.onValueChange,
    );
  }
}
