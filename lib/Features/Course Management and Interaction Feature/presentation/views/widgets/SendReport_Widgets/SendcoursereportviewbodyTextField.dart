import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class SendcoursereportviewbodyTextField extends StatelessWidget {
  const SendcoursereportviewbodyTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        maxLines: 4,
        hintText: LocaleKeys.hintWriteMessage,
        obscureText: false,
        onSaved: (val) {
          context.read<CourseReportEntity>().description = val ?? "";
        },
        textInputType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return LocaleKeys.writeMessageHint;
          }
          return null;
        });
  }
}
