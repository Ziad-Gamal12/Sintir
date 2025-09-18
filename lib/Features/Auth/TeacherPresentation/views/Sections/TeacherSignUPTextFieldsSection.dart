// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/GenderSelectionInput.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherExperienceTextField.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignFirstAndLastNameField.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUSubjectFiled.dart';
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
      children: [
        const TeacherSignFirstAndLastNameField(),
        const SizedBox(height: 10),
        const TeacherSignUpEmailAddressFiled(),
        const SizedBox(height: 10),
        const TeacherSignUpAddressFiled(),
        const SizedBox(height: 10),
        const TeacherSignUpPhoneNumberFiled(),
        const SizedBox(height: 10),
        const TeacherSignUSubjectFiled(),
        const SizedBox(height: 10),
        const SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: TeacherExperienceTextField()),
              Expanded(child: GenderSelectionInput())
            ],
          ),
        ),
        const SizedBox(height: 10),
        TeacherSignUpPasswordTextField(
          teacherSignUpPasswordController: teacherSignUpPasswordController,
        )
      ],
    );
  }
}
