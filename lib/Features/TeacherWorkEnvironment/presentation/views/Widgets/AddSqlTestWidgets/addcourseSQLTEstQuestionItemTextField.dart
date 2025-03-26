import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';

// ignore: must_be_immutable
class AddcourseSQLTEstQuestionItemTextField extends StatelessWidget {
  const AddcourseSQLTEstQuestionItemTextField({
    super.key,
    required this.coursetestquestionentity,
  });
  final Coursetestquestionentity coursetestquestionentity;
  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
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
