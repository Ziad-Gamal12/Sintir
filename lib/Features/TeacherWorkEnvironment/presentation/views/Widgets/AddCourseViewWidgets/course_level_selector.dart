import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomEducationLevelDropdownButton.dart';

class CourseLevelSelector extends StatelessWidget {
  final ValueChanged<String?> onChanged;

  const CourseLevelSelector({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomEducationLevelDropdownButton(onValueChange: onChanged);
  }
}
