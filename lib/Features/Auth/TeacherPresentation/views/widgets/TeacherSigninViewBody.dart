// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherAuthListeners/teacherBlocListenerMethods.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherLoginViewBodyForgetPasswordText.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignInViewBodyCustomButton.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignInViewBodyTextFieledInPuts.dart';
import 'package:sintir/constant.dart';

class TeacherSigninViewBody extends StatefulWidget {
  const TeacherSigninViewBody({super.key});

  @override
  State<TeacherSigninViewBody> createState() => _TeacherSigninViewBodyState();
}

class _TeacherSigninViewBodyState extends State<TeacherSigninViewBody> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignInCubit, TeacherSignInState>(
      listener: (context, state) {
        teacherSignInBlocListener(context, state);
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
              key: Variables.TeacherLoginFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: 24),
                child: Column(
                  children: [
                    const TeacherSignInViewBodyTextFieledInPuts(),
                    const Customsizedbox(width: 0, height: 16),
                    const TeacherLoginViewBodyForgetPasswordText(),
                    const Customsizedbox(width: 0, height: 30),
                    Custom_Loading_Widget(
                        isLoading: state is TeacherSignInLoading,
                        child: const TeacherSignInViewBodyCustomButton()),
                    const Customsizedbox(width: 0, height: 30),
                    CustomLoginViewBodyDonotHaveAccountText(
                      onTap: () {
                        GoRouter.of(context).push(TeacherSignUpView.routeName);
                      },
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
