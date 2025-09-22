import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class EditCourseDescriptionField extends StatelessWidget {
  const EditCourseDescriptionField({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CourseEntity course = context.read<CourseEntity>();

    return CustomTextField(
      hintText: "يرجى تقديم وصف مختصر للأهداف الرئيسية للدورة..",
      obscureText: false,
      controller: TextEditingController(
        text: course.description,
      ),
      onSaved: (value) {
        course.description = value!;
      },
      maxLines: 5,
      textInputType: TextInputType.text,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "ادخل وصف الدورة";
        }
        return null;
      },
    );
  }
}
