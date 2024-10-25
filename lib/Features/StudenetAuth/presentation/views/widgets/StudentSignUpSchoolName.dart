// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class Studentsignupschoolname extends StatelessWidget {
  const Studentsignupschoolname({super.key});

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "اسم مدرستك",
        prefixIcon: Icons.school_outlined,
        obscureText: false,
        controller: Variables.studentSignUpSchoolNameController,
        textInputType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل اسم مدرستك";
          } else {
            return null;
          }
        });
  }
}
