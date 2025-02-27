// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionTextFields.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionviewbody extends StatelessWidget {
  const Addcoursesectionviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CourseSectionTextFields(),
          const Divider(
            height: 40,
            color: Colors.grey,
          ),
          Text(
            "المحتوى",
            style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          const AddCourseSectionContentOptions()
        ],
      ),
    );
  }
}
