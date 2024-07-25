import 'package:flutter/material.dart';
import 'package:sintir/Core/Widgets/CustomTextFeiled.dart';

class StudentSigninviewBodyEmailandpassword extends StatelessWidget {
  TextEditingController StudentEmailController = TextEditingController();
  TextEditingController StudentPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFeiled(
          controller: StudentEmailController,
          hintText: "البريد الالكتروني",
          validator: (value) {
            if (value!.isEmpty) {
              return "برجاء ادخال البريد الالكتروني";
            } else {
              return null;
            }
          },
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          suffix: null,
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextFeiled(
          controller: StudentPasswordController,
          hintText: "كلمة المرور",
          validator: (value) {
            if (value!.isEmpty) {
              return "برجاء ادخال كلمة المرور";
            } else {
              return null;
            }
          },
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          suffix: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.visibility_off,
                color: Color(0xff949D9E),
              )),
        ),
      ],
    );
  }
}
