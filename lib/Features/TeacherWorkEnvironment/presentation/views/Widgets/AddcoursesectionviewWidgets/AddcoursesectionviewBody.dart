// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionTextFields.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Addcoursesectionviewbody extends StatelessWidget {
  const Addcoursesectionviewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: Variables.AddCourseSectionFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CourseSectionTextFields(),
            Divider(
              height: 40,
              color: theme.dividerColor,
            ),
            Text(
              LocaleKeys.content,
              style: AppTextStyles(context)
                  .bold20
                  .copyWith(color: theme.textTheme.bodyMedium?.color),
            ),
            const SizedBox(
              height: 20,
            ),
            AddCourseSectionContentOptions(
              onSave: () {
                if (Variables.AddCourseSectionFormKey.currentState != null) {
                  if (Variables.AddCourseSectionFormKey.currentState!
                      .validate()) {
                    Variables.AddCourseSectionFormKey.currentState!.save();
                  }
                }
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
