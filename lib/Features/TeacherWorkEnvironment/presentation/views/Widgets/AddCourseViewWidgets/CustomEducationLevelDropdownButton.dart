import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/EducationLevelDropdownEntityItem.dart';
import 'package:sintir/locale_keys.dart';

class CustomEducationLevelDropdownButton extends StatefulWidget {
  const CustomEducationLevelDropdownButton({
    super.key,
    required this.onValueChange,
  });
  final ValueChanged<String?> onValueChange;
  @override
  State<CustomEducationLevelDropdownButton> createState() =>
      _CustomEducationLevelDropdownButtonState();
}

class _CustomEducationLevelDropdownButtonState
    extends State<CustomEducationLevelDropdownButton> {
  List<String> items = EducationLevelDropdownEntityItem.getSubjectsLabels();
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: items,
      hintText: LocaleKeys.studentEducationLevel,
      onChanged: widget.onValueChange,
    );
  }
}
