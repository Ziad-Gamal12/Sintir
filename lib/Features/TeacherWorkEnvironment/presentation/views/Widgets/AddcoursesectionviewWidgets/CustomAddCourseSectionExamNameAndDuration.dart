import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddCourseSectionExamNameAndDuration extends StatelessWidget {
  const CustomAddCourseSectionExamNameAndDuration({
    super.key,
    required this.coursetestentity,
  });
  final CourseTestEntity coursetestentity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: CustomTextField(
                hintText: LocaleKeys.examName,
                obscureText: false,
                onSaved: (value) {
                  coursetestentity.title = value!;
                },
                textInputType: TextInputType.text,
                prefixIcon: Icons.text_snippet_outlined,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.enterExamName;
                  }
                  return null;
                })),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 2,
            child: CustomTextField(
                onSaved: (value) {
                  coursetestentity.durationTime = int.tryParse(value!) ?? 0;
                },
                hintText: LocaleKeys.examDuration,
                obscureText: false,
                textInputType: TextInputType.number,
                prefixIcon: Icons.timer_outlined,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.enterDuration;
                  }
                  return null;
                }))
      ],
    );
  }
}
