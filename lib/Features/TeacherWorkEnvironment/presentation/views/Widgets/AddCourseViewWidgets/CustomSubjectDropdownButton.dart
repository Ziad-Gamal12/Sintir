import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubjectDropdownEntityItem.dart';
import 'package:sintir/locale_keys.dart';

class CustomSubjectDropdownButton extends StatefulWidget {
  const CustomSubjectDropdownButton({super.key, required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  State<CustomSubjectDropdownButton> createState() =>
      _CustomSubjectDropdownButtonState();
}

class _CustomSubjectDropdownButtonState
    extends State<CustomSubjectDropdownButton> {
  List<String> items = SubjectDropdownEntityItem.getSubjectsLabels();
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: items,
      hintText: LocaleKeys.subjectHint,
      onChanged: widget.onValueChange,
    );
  }
}
