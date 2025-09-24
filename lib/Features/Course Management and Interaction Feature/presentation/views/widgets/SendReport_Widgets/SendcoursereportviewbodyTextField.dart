import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class SendcoursereportviewbodyTextField extends StatelessWidget {
  const SendcoursereportviewbodyTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        maxLines: 4,
        hintText: "اكتب ملاحظتك هنا ....",
        obscureText: false,
        onSaved: (val) {
          context.read<CourseReportEntity>().description = val ?? "";
        },
        textInputType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "لا يمكن ان يكون الحقل فارغ";
          }
          return null;
        });
  }
}
