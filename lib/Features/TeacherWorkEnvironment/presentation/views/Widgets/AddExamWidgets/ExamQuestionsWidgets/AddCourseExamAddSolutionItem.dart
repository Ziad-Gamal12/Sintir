import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class AddCourseExamAddSolutionItem extends StatelessWidget {
  const AddCourseExamAddSolutionItem({
    super.key,
    required this.coursetestquestionsolutionentity,
    required this.groupValue,
    required this.onChange,
  });

  final CourseTestQuestionSolutionEntity coursetestquestionsolutionentity;
  final String groupValue;
  final ValueChanged<String?> onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioWidget(
          value: coursetestquestionsolutionentity.id,
          groupValue: groupValue,
          onchange: onChange,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: CustomTextField(
            controller: coursetestquestionsolutionentity.solutionController,
            hintText: LocaleKeys.answer,
            obscureText: false,
            textInputType: TextInputType.text,
            onSaved: (value) {
              coursetestquestionsolutionentity.answer = value ?? "";
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.enterAnswer;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
