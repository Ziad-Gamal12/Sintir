// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomEducationLevelDropdownButton.dart';

class CustomstudentsignupSchoollevel extends StatelessWidget {
  const CustomstudentsignupSchoollevel({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomEducationLevelDropdownButton(
      onValueChange: (value) {
        context.read<UserEntity>().studentExtraDataEntity?.educationLevel =
            value ?? "";
      },
    );
  }
}
