// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TeacherSignUPGenderAndExperienceAndSubjectSection.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignFirstAndLastNameField.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUpAddressFiled.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUpEmailAddressFiled.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSigninPasswordTextField.dart';

class TeacherSignUPTextFieldsSection extends StatelessWidget {
  const TeacherSignUPTextFieldsSection({
    super.key,
    required this.teacherSignUpPasswordController,
  });
  final TextEditingController teacherSignUpPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        const TeacherSignFirstAndLastNameField(),
        const TeacherSignUpEmailAddressFiled(),
        const TeacherSignUpAddressFiled(),
        const TeacherSignUpPhoneNumberFiled(),
        const TeacherSignUPGenderAndExperienceAndSubjectSection(),
        TeacherSignUpPasswordTextField(
          teacherSignUpPasswordController: teacherSignUpPasswordController,
        )
      ],
    );
  }
}
