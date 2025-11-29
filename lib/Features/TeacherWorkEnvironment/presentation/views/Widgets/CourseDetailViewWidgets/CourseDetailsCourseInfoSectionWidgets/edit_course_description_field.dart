import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class EditCourseDescriptionField extends StatelessWidget {
  const EditCourseDescriptionField({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CourseEntity course = context.read<CourseEntity>();
    return CustomTextField(
      hintText: LocaleKeys.courseDescription,
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
          return LocaleKeys.enterCourseDescription;
        }
        return null;
      },
    );
  }
}
