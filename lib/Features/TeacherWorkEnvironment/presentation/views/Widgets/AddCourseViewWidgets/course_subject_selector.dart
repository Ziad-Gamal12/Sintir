import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomSubjectDropdownButton.dart';

class CourseSubjectSelector extends StatelessWidget {
  final ValueChanged<String?> onChanged;

  const CourseSubjectSelector({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomSubjectDropdownButton(onValueChange: onChanged);
  }
}
