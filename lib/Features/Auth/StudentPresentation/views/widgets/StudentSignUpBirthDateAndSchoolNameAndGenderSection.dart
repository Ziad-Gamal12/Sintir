import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/CustomStudentSignUP_SchoolLevel.dart';
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
          child: Column(
            children: [
              StudentsignupBirthdayfield(),
              SizedBox(height: 10),
              CustomstudentsignupSchoollevel(),
            ],
          ),
        ),
        SizedBox(height: 10),
        StudentGenderSelectionInput()
      ],
    );
  }
}
