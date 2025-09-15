import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentGenderSelectionInput.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUp_BirthDayField.dart';

class StudentSignUpBirthDateAndSchoolNameAndGenderSection
    extends StatelessWidget {
  const StudentSignUpBirthDateAndSchoolNameAndGenderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 1,
          child: StudentsignupBirthdayfield(),
        ),
        Customsizedbox(width: 0, height: 10),
        StudentGenderSelectionInput()
      ],
    );
  }
}
