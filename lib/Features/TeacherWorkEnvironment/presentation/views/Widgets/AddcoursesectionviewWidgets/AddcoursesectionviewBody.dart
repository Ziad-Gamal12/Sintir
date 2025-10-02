// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionTextFields.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionviewbody extends StatelessWidget {
  const Addcoursesectionviewbody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: Variables.AddCourseSectionFormKey,
      child: Padding(
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
              style:
                  AppTextStyles(context).bold20.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            AddCourseSectionContentOptions(
              onSave: () {
                Variables.AddCourseSectionFormKey.currentState!.save();
              },
              optionRequirementsEntity:
                  context.read<OptionNavigationRequirementsEntity>(),
            )
          ],
        ),
      ),
    );
  }
}
