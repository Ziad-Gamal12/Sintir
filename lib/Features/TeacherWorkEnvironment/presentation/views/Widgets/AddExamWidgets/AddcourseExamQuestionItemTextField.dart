import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

// ignore: must_be_immutable
class AddcourseExamQuestionItemTextField extends StatelessWidget {
  const AddcourseExamQuestionItemTextField({
    super.key,
    required this.coursetestquestionentity,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        controller: coursetestquestionentity.questionController,
        hintText: "يرجى كتابه السؤال هنا ...",
        obscureText: false,
        textInputType: TextInputType.text,
        onSaved: (value) {
          coursetestquestionentity.questionTitle = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل السؤال";
          }
          return null;
        });
  }
}
