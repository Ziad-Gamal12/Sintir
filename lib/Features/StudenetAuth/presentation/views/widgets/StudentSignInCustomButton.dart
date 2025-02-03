import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/constant.dart';

class StudentSignInCustomButton extends StatelessWidget {
  const StudentSignInCustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "تسجيل الدخول",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          BlocProvider.of<StudentSignInCubit>(context)
              .signInWithEmailAndPassword(
                  email: Variables.StudentSigninEmailController.text,
                  password: Variables.StudentSigninPasswordController.text);
        });
  }
}
