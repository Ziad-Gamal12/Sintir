// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class TeacherSignUSubjectFiled extends StatelessWidget {
  const TeacherSignUSubjectFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "المادة الدراسية",
        prefixIcon: Icons.menu_book_rounded,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().teacherExtraDataEntity?.subject =
              val ?? "";
        },
        textInputType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل المادةالدراسية";
          }
          return null;
        });
  }
}
