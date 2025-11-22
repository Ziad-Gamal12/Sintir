import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/GenderSelectionInput.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherExperienceTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomSubjectDropdownButton.dart';

class TeacherSignUPGenderAndExperienceAndSubjectSection
    extends StatelessWidget {
  const TeacherSignUPGenderAndExperienceAndSubjectSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const TeacherExperienceTextField(),
                CustomSubjectDropdownButton(
                  onValueChange: (value) {
                    context.read<UserEntity>().teacherExtraDataEntity?.subject =
                        value ?? "";
                  },
                ),
              ],
            )),
        const Expanded(child: GenderSelectionInput())
      ],
    );
  }
}
