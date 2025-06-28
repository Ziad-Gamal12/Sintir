import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class EditCourseDescriptionField extends StatelessWidget {
  EditCourseDescriptionField({super.key, required this.courseDescription});
  String courseDescription;
  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
      hintText: "يرجى تقديم وصف مختصر للأهداف الرئيسية للدورة..",
      obscureText: false,
      controller: TextEditingController(
        text: courseDescription,
      ),
      onSaved: (value) {
        courseDescription = value!;
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
