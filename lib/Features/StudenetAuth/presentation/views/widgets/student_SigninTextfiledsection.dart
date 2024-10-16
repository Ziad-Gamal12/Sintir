import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class student_SigninTextfiledsection extends StatefulWidget {
  const student_SigninTextfiledsection({super.key});

  @override
  State<student_SigninTextfiledsection> createState() =>
      _SigninTextfiledsectionState();
}

bool _obscureText = true;

class _SigninTextfiledsectionState
    extends State<student_SigninTextfiledsection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Customteaxtfield(
            hintText: "البريد الالكتروني",
            prefixIcon: Icons.email_outlined,
            obscureText: false,
            controller: Variables.StudentSigninEmailController,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل البريد الالكتروني";
              } else if (!value.contains("@")) {
                return "ادخل البريد الالكتروني صحيح";
              }
              return null;
            }),
        const Customsizedbox(width: 0, height: 10),
        Customteaxtfield(
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
            controller: Variables.TeacherLoginPasswordController,
            textInputType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل كلمة المرور";
              }
              return null;
            })
      ],
    );
  }
}
