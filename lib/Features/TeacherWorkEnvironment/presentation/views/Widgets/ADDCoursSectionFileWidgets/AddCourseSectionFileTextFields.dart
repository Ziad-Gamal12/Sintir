import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

class AddCourseSectionFileTextFields extends StatelessWidget {
  const AddCourseSectionFileTextFields({
    super.key,
    required this.coursefilEentity,
  });
  final CourseFileEntity coursefilEentity;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            hintText: "يرجى كتابه اسم الملف هنا ...",
            obscureText: false,
            textInputType: TextInputType.text,
            onSaved: (value) {
              coursefilEentity.title = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل اسم الملف";
              }
              return null;
            }),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            maxLines: 4,
            hintText: "يرجى كتابه وصف الملف هنا ...",
            obscureText: false,
            textInputType: TextInputType.text,
            onSaved: (value) {
              coursefilEentity.description = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل وصف الملف";
              }
              return null;
            }),
      ],
    );
  }
}
