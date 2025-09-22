import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class EditCourseTitleField extends StatelessWidget {
  const EditCourseTitleField({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CourseEntity course = context.read<CourseEntity>();
    return CustomTextField(
      hintText: "يرجى كتابه أسم الدورة هنا ...",
      obscureText: false,
      controller: TextEditingController(text: course.title),
      onSaved: (value) {
        course.title = value!;
      },
      textInputType: TextInputType.text,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "ادخل اسم الدورة";
        }
        return null;
      },
    );
  }
}
