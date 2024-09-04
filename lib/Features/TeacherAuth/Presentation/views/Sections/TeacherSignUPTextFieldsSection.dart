import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/ExperienceAndPhotoInput.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/GenderSelectionInput.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignFirstAndLastNameField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUSubjectFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpAddressFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpEmailAddressFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSigninPasswordTextField.dart';

class TeacherSignUPTextFieldsSection extends StatefulWidget {
  const TeacherSignUPTextFieldsSection({
    super.key,
    required this.width,
    required this.radiovalue,
    required this.onchanged,
  });

  final double width;
  final String? radiovalue;
  final ValueChanged<String?> onchanged;

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
    return Column(
      children: [
        TeacherSignFirstAndLastNameField(width: widget.width),
        const Customsizedbox(width: 0, height: 10),
        const TeacherSignUpEmailAddressFiled(),
        const Customsizedbox(width: 0, height: 10),
        const TeacherSignUpAddressFiled(),
        const Customsizedbox(width: 0, height: 10),
        const TeacherSignUpPhoneNumberFiled(),
        const Customsizedbox(width: 0, height: 10),
        const TeacherSignUSubjectFiled(),
        const Customsizedbox(width: 0, height: 10),
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExperienceAndPhotoInput(),
              GenderSelectionInput(
                  onChanged: widget.onchanged,
                  radiovalue: widget.radiovalue ?? "ذكر",
                  expandedFlex: 1)
            ],
          ),
        ),
        const Customsizedbox(width: 0, height: 10),
        const TeacherSigninPasswordTextField()
      ],
    );
  }
}
