import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/constant.dart';

class TeacherSignInViewBodyCustomButton extends StatelessWidget {
  const TeacherSignInViewBodyCustomButton({
    super.key,
    required this.teacherSignInPasswordController,
    required this.teacherSignInEmailController,
    required this.teacherLoginFormKey,
  });
  final TextEditingController teacherSignInPasswordController;
  final TextEditingController teacherSignInEmailController;
  final GlobalKey<FormState> teacherLoginFormKey;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "تسجيل دخول",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (teacherLoginFormKey.currentState!.validate()) {
            context.read<TeacherSignInCubit>().signInWithEmailAndPassword(
                email: teacherSignInEmailController.text,
                password: teacherSignInPasswordController.text);
          }
        });
  }
}
