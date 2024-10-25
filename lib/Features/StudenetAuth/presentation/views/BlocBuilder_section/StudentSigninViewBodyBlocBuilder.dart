// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Core/widgets/CustomSepratedWidget.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/Student_signUp_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/Student_SigninSocialbuttonssection.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/student_SigninTextfiledsection.dart';
import 'package:sintir/constant.dart';

import '../../../../../Core/utils/textStyles.dart';

class StudentSigninViewBodyBlocBuilder extends StatelessWidget {
  const StudentSigninViewBodyBlocBuilder({
    required this.state,
    super.key,
  });
  final StudentSignInState state;
  @override
  Widget build(BuildContext context) {
    return Custom_Loading_Widget(
      isLoading: state is StudentSignInLoading ? true : false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Customsizedbox(width: 0, height: 12),
              const student_SigninTextfiledsection(),
              const Customsizedbox(width: 0, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push(CustomResetPasswordView.routeName);
                    },
                    child: Text(
                      "نسيت كلمة المرور؟",
                      style: AppTextStyles.semiBold13Auto
                          .copyWith(color: KMainColor),
                    ),
                  )
                ],
              ),
              const Customsizedbox(width: 0, height: 30),
              Custombutton(
                  text: "تسجيل الدخول",
                  color: KMainColor,
                  textColor: Colors.white,
                  onPressed: () {
                    BlocProvider.of<StudentSignInCubit>(context)
                        .signInWithEmailAndPassword(
                            email: Variables.StudentSigninEmailController.text,
                            password:
                                Variables.StudentSigninPasswordController.text);
                  }),
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
      ),
    );
  }
}
