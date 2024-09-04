import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherPasswordTextField extends StatefulWidget {
  const TeacherPasswordTextField({super.key});

  @override
  State<TeacherPasswordTextField> createState() =>
      _TeacherPasswordTextFieldState();
}

class _TeacherPasswordTextFieldState extends State<TeacherPasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: _obscureText
                ? const Icon(
                    Icons.visibility_off_outlined,
                    size: 24,
                    color: Color(0xffAEAEB2),
                  )
                : const Icon(
                    Icons.visibility_outlined,
                    size: 24,
                    color: Color(0xffAEAEB2),
                  )),
        hintText: "كلمة المرور",
        prefixIcon: Icons.lock_outline,
        obscureText: _obscureText,
        controller: Variables.TeacherPasswordController,
        textInputType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل كلمة المرور";
          }
          return null;
        });
  }
}
