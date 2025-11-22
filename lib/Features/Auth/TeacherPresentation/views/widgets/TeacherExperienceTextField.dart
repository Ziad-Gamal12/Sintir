// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class TeacherExperienceTextField extends StatelessWidget {
  const TeacherExperienceTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "عدد سنين الخبرة",
        prefixIcon: Icons.workspace_premium,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().teacherExtraDataEntity?.workExperience =
              val ?? "";
        },
        textInputType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل عدد سنين الخبرة الخاصة بك";
          }
          return null;
        });
  }
}
