import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

/// Text field for one answer. Long answers wrap onto up to three lines
/// instead of scrolling sideways.
class AddCourseExamAddSolutionItem extends StatelessWidget {
  const AddCourseExamAddSolutionItem({
    super.key,
    required this.coursetestquestionsolutionentity,
  });

  final CourseTestQuestionSolutionEntity coursetestquestionsolutionentity;

  /// The style the field's text is laid out with, for controls that line up
  /// with its first line.
  static TextStyle effectiveTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final base = theme.useMaterial3
        ? theme.textTheme.bodyLarge
        : theme.textTheme.titleMedium;
    return (base ?? const TextStyle()).merge(AppTextStyles(context).semiBold14);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: coursetestquestionsolutionentity.solutionController,
      hintText: LocaleKeys.answer,
      obscureText: false,
      textInputType: TextInputType.text,
      minLines: 1,
      maxLines: 3,
      onSaved: (value) {
        coursetestquestionsolutionentity.answer = value ?? "";
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return LocaleKeys.enterAnswer;
        }
        return null;
      },
    );
  }
}
