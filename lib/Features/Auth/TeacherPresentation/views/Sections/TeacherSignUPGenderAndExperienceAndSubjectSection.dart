import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AdaptiveFormRow.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherExperienceTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubjectDropdownEntityItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomSubjectDropdownButton.dart';

/// Years of experience + subject. Gender moved next to the password field
/// (see TeacherSignUPTextFieldsSection) as a segmented input.
class TeacherSignUPGenderAndExperienceAndSubjectSection
    extends StatelessWidget {
  const TeacherSignUPGenderAndExperienceAndSubjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveFormRow(
      children: [
        const TeacherExperienceTextField(),
        CustomSubjectDropdownButton(
          onValueChange: (label) {
            if (label != null) {
              final value = SubjectDropdownEntityItem.getValueByLabel(
                label,
              );
              context.read<UserEntity>().teacherExtraDataEntity?.subject =
                  value;
            }
          },
        ),
      ],
    );
  }
}
