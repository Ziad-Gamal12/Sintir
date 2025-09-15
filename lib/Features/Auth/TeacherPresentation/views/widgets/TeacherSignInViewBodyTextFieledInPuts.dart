import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherLoginEmailAdressTextFiled.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherLoginPasswordTextField.dart';

class TeacherSignInViewBodyTextFieledInPuts extends StatelessWidget {
  const TeacherSignInViewBodyTextFieledInPuts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TeacherLoginEmailAdressTextFiled(),
        Customsizedbox(width: 0, height: 10),
        Teacherloginpasswordtextfield(),
      ],
    );
  }
}
