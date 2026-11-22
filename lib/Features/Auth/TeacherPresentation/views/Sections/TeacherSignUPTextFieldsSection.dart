// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/AdaptiveFormRow.dart';
import 'package:sintir/Core/widgets/GenderSegmentedInput.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        const TeacherSignFirstAndLastNameField(),
        const TeacherSignUpEmailAddressFiled(),
        AdaptiveFormRow(
          children: [
            const TeacherSignUpPhoneNumberFiled(),
            GenderSegmentedInput(
              initialValue: context.read<UserEntity>().gender,
              onChanged: (value) => context.read<UserEntity>().gender = value,
            ),
          ],
        ),
        const SizedBox(height: 4),
        const TeacherSignUPGenderAndExperienceAndSubjectSection(),
        const TeacherSignUpAddressFiled(),
        const SizedBox(height: 4),
        TeacherSignUpPasswordTextField(
          teacherSignUpPasswordController: teacherSignUpPasswordController,
        ),
      ],
    );
  }
}
