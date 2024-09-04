import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherSignFirstAndLastNameField extends StatelessWidget {
  const TeacherSignFirstAndLastNameField({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: (width * .5) - 21,
          child: Customteaxtfield(
              hintText: "الأسم الأول",
              prefixIcon: Icons.person_2_outlined,
              obscureText: false,
              controller: Variables.TeacherSigninFirstNameController,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل الأسم الأول";
                } else {
                  return null;
                }
              }),
        ),
        const Customsizedbox(width: 10, height: 0),
        SizedBox(
          width: (width * .5) - 21,
          child: Customteaxtfield(
              hintText: "الأسم الأخير",
              prefixIcon: Icons.person_2_outlined,
              obscureText: false,
              controller: Variables.TeacherSigninLastNameController,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل الأسم الأخير";
                } else {
                  return null;
                }
              }),
        ),
      ],
    );
  }
}
