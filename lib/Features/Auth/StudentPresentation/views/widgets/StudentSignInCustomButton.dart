import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/constant.dart';

class StudentSignInCustomButton extends StatelessWidget {
  const StudentSignInCustomButton({
    super.key,
    required this.studentSignInEmailController,
    required this.studentSignInPasswordController,
    required this.studetSignInFormKey,
  });
  final TextEditingController studentSignInEmailController;
  final TextEditingController studentSignInPasswordController;
  final GlobalKey<FormState> studetSignInFormKey;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "تسجيل الدخول",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (studetSignInFormKey.currentState!.validate()) {
            BlocProvider.of<StudentSignInCubit>(context)
                .signInWithEmailAndPassword(
                    email: studentSignInEmailController.text,
                    password: studentSignInPasswordController.text);
          }
        });
  }
}
