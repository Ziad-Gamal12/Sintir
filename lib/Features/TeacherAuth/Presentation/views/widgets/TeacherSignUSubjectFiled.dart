import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherSignUSubjectFiled extends StatelessWidget {
  const TeacherSignUSubjectFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "المادة الدراسية",
        prefixIcon: Icons.menu_book_rounded,
        obscureText: false,
        controller: Variables.TeacherSubjectController,
        textInputType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل المادةالدراسية";
          }
          return null;
        });
  }
}
