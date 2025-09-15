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

class TeacherSignUPTextFieldsSection extends StatefulWidget {
  const TeacherSignUPTextFieldsSection({
    super.key,
  });

  @override
  State<TeacherSignUPTextFieldsSection> createState() =>
      _TeacherSignUPTextFieldsSectionState();
}

class _TeacherSignUPTextFieldsSectionState
    extends State<TeacherSignUPTextFieldsSection> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return const Column(
      children: [
        TeacherSignFirstAndLastNameField(),
        SizedBox(height: 10),
        TeacherSignUpEmailAddressFiled(),
        SizedBox(height: 10),
        TeacherSignUpAddressFiled(),
        SizedBox(height: 10),
        TeacherSignUpPhoneNumberFiled(),
        SizedBox(height: 10),
        TeacherSignUSubjectFiled(),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: TeacherExperienceTextField()),
              Expanded(child: GenderSelectionInput())
            ],
          ),
        ),
        SizedBox(height: 10),
        TeacherSigninPasswordTextField()
      ],
    );
  }
}
