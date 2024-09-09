// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginEmailAdressTextFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginPasswordTextField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginViewBodyForgetPasswordText.dart';
import 'package:sintir/constant.dart';

class TeacherLoginViewBody extends StatefulWidget {
  const TeacherLoginViewBody({super.key});

  @override
  State<TeacherLoginViewBody> createState() => _TeacherLoginViewBodyState();
}

class _TeacherLoginViewBodyState extends State<TeacherLoginViewBody> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignInCubit, TeacherSignInState>(
      listener: (context, state) {
        if (state is TeacherSignInSuccess) {
          successdialog(
                  context: context,
                  SuccessMessage: "تم تسجيل الدخول بنجاح",
                  btnOkOnPress: () {})
              .show();
        } else if (state is TeacherSignInFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is TeacherSignInLoading ? true : false,
          child: SingleChildScrollView(
            child: Form(
                key: Variables.TeacherLoginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: KHorizontalPadding, vertical: 24),
                  child: Column(
                    children: [
                      const TeacherLoginEmailAdressTextFiled(),
                      const Customsizedbox(width: 0, height: 10),
                      const Teacherloginpasswordtextfield(),
                      const Customsizedbox(width: 0, height: 16),
                      const TeacherLoginViewBodyForgetPasswordText(),
                      const Customsizedbox(width: 0, height: 30),
                      Custombutton(
                          text: "تسجيل دخول",
                          color: KMainColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (Variables.TeacherLoginFormKey.currentState!
                                .validate()) {
                              context
                                  .read<TeacherSignInCubit>()
                                  .signInWithEmailAndPassword(
                                      email: Variables
                                          .TeacherLoginEmailController.text,
                                      password: Variables
                                          .TeacherLoginPasswordController.text);
                            }
                          }),
                      const Customsizedbox(width: 0, height: 30),
                      const TeacherLoginViewBodyDonotHaveAccountText()
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
