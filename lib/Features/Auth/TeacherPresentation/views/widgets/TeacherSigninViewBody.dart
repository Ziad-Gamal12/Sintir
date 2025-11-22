// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherAuthListeners/teacherBlocListenerMethods.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherLoginViewBodyForgetPasswordText.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignInViewBodyCustomButton.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignInViewBodyTextFieledInPuts.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSigninViewBodyWelcomeSection.dart';
import 'package:sintir/constant.dart';

class TeacherSigninViewBody extends StatefulWidget {
  const TeacherSigninViewBody({super.key});

  @override
  State<TeacherSigninViewBody> createState() => _TeacherSigninViewBodyState();
}

class _TeacherSigninViewBodyState extends State<TeacherSigninViewBody> {
  late TextEditingController teacherSignInPasswordController;
  late TextEditingController teacherSignInEmailController;
  late GlobalKey<FormState> teacherLoginFormKey;

  @override
  void initState() {
    super.initState();
    teacherSignInPasswordController = TextEditingController();
    teacherSignInEmailController = TextEditingController();
    teacherLoginFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    teacherSignInPasswordController.dispose();
    teacherSignInEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignInCubit, TeacherSignInState>(
      listener: (context, state) {
        teacherSignInBlocListener(context, state);
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
              key: teacherLoginFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: KVerticalPadding),
                child: Column(
                  children: [
                    const TeacherSigninViewBodyWelcomeSection(),
                    const SizedBox(
                      height: 48,
                    ),
                    TeacherSignInViewBodyTextFieledInPuts(
                      teacherSignInPasswordController:
                          teacherSignInPasswordController,
                      teacherSignInEmailController:
                          teacherSignInEmailController,
                    ),
                    const SizedBox(height: 16),
                    const TeacherLoginViewBodyForgetPasswordText(),
                    const SizedBox(height: 32),
                    Custom_Loading_Widget(
                        isLoading: state is TeacherSignInLoading,
                        child: TeacherSignInViewBodyCustomButton(
                          teacherLoginFormKey: teacherLoginFormKey,
                          teacherSignInPasswordController:
                              teacherSignInPasswordController,
                          teacherSignInEmailController:
                              teacherSignInEmailController,
                        )),
                    const SizedBox(height: 32),
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
