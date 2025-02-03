import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentGenderSelectionInput.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpSchoolName.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUp_BirthDayField.dart';

class StudentSignUpBirthDateAndSchoolNameAndGenderSection
    extends StatelessWidget {
  const StudentSignUpBirthDateAndSchoolNameAndGenderSection({
    super.key,
    required this.radioValue,
    required this.birhdaydate,
    required this.gender,
  });

  final String? radioValue;
  final ValueChanged<DateTime?> birhdaydate;
  final ValueChanged<String?> gender;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                StudentsignupBirthdayfield(
                  birhdaydate: birhdaydate,
                ),
                const Customsizedbox(width: 0, height: 10),
                const Studentsignupschoolname()
              ],
            )),
        const Customsizedbox(width: 0, height: 10),
        StudentGenderSelectionInput(
            onChanged: gender, radiovalue: radioValue ?? "ذكر", expandedFlex: 2)
      ],
    );
  }
}
