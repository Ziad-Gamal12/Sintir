import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class EditCourseTitleField extends StatelessWidget {
  EditCourseTitleField({super.key, required this.courseTitle});
  String courseTitle;
  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
      hintText: "يرجى كتابه أسم الدورة هنا ...",
      obscureText: false,
      controller: TextEditingController(text: courseTitle),
      onSaved: (value) {
        courseTitle = value!;
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
