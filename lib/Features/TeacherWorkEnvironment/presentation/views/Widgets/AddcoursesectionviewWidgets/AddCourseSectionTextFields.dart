import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class CourseSectionTextFields extends StatelessWidget {
  const CourseSectionTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Customteaxtfield(
          hintText: "يرجى كتابه اسم المحاضرة هنا ...",
          obscureText: false,
          controller: Variables.AddCoursesectionNameController,
          textInputType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return "ادخل اسم المحاضرة";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        Customteaxtfield(
          hintText: "يرجى كتابه وصف المحاضرة هنا ...",
          obscureText: false,
          controller: Variables.AddCoursesesectionDescriptionController,
          textInputType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return "ادخل وصف المحاضرة";
            }
            return null;
          },
        ),
      ],
    );
  }
}
