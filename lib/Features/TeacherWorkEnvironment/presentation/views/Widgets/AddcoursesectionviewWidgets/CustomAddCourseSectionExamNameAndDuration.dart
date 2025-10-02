import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

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
                hintText: "يرجى كتابه الأسم هنا ...",
                obscureText: false,
                onSaved: (value) {
                  coursetestentity.title = value!;
                },
                controller: Variables.AddExamName,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ادخل الاسم";
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
                hintText: "مده الأختبار",
                obscureText: false,
                controller: Variables.AddExamDuration,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ادخل المده";
                  }
                  return null;
                }))
      ],
    );
  }
}
