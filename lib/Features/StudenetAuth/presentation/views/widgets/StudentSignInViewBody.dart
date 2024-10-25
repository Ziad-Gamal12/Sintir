// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/BlocBuilder_section/StudentSigninViewBodyBlocBuilder.dart';

class StudentSignInViewBody extends StatefulWidget {
  const StudentSignInViewBody({super.key});

  @override
  State<StudentSignInViewBody> createState() => _StudentSignInViewBodyState();
}

class _StudentSignInViewBodyState extends State<StudentSignInViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentSignInCubit, StudentSignInState>(
      listener: (context, state) {
        if (state is StudentSignInSuccess) {
          successdialog(
                  context: context,
                  SuccessMessage: "تم تسجيل الدخول بنجاح",
                  btnOkOnPress: () {})
              .show();
        } else if (state is StudentSignInFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return StudentSigninViewBodyBlocBuilder(
          state: state,
        );
      },
    );
  }
}
