import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomCourseLanguageDropdownButton.dart';

class CourseLanguageSelector extends StatelessWidget {
  final ValueChanged<String?> onChanged;

  const CourseLanguageSelector({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomLanguageDropdownButton(onValueChange: onChanged);
  }
}
