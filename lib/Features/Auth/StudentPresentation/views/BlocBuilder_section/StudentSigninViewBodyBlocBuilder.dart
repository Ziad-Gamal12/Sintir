// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Core/widgets/CustomSepratedWidget.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_signUp_View.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignInCustomButton.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignInForgetPasswordTextWidget.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/Student_SigninSocialbuttonssection.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/student_SigninTextfiledsection.dart';
import 'package:sintir/constant.dart';

class StudentSigninViewBodyBlocBuilder extends StatelessWidget {
  const StudentSigninViewBodyBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StudentSignInCubit, StudentSignInState, bool>(
      selector: (state) {
        if (state is StudentSignInLoading) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Customsizedbox(width: 0, height: 12),
                const student_SigninTextfiledsection(),
                const Customsizedbox(width: 0, height: 16),
                const StudentSignInForgetPasswordTextWidget(),
                const Customsizedbox(width: 0, height: 30),
                Custom_Loading_Widget(
                  isLoading: state,
                  child: const StudentSignInCustomButton(),
                ),
                const Customsizedbox(width: 0, height: 30),
                CustomLoginViewBodyDonotHaveAccountText(onTap: () {
                  GoRouter.of(context).push(StudentSignupView.routeName);
                }),
                const Customsizedbox(width: 0, height: 55),
                const Customsepratedwidget(
                  centerTitle: "او",
                ),
                const Customsizedbox(width: 0, height: 30),
                const Student_SigninSocialbuttonssection()
              ],
            ),
          ),
        );
      },
    );
  }
}
