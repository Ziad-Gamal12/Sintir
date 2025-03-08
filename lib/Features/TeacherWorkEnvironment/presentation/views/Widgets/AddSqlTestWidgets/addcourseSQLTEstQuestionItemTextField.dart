import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';

class AddcourseSQLTEstQuestionItemTextField extends StatelessWidget {
  const AddcourseSQLTEstQuestionItemTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "يرجى كتابه السؤال هنا ...",
        obscureText: false,
        textInputType: TextInputType.text,
        onSaved: (value) {
          context.read<Coursetestquestionentity>().questionTitle = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل السؤال";
          }
          return null;
        });
  }
}
