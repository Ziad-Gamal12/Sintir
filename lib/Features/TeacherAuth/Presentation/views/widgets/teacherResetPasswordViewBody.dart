// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/teacherResetPassword/teacher_reset_password_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/BlocBuilder/teacherResetPasswordViewBodyBlocBuilder.dart';

class teacherResetPasswordViewBody extends StatelessWidget {
  const teacherResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherResetPasswordCubit, TeacherResetPasswordState>(
      listener: (context, state) {
        if (state is TeacherResetPasswordSuccess) {
          successdialog(
              context: context,
              SuccessMessage: "بنجاح,تم ارسال رسالة تحقق على بريدك الالكتروني",
              btnOkOnPress: () {
                GoRouter.of(context).pop();
              }).show();
        } else if (state is TeacherResetPasswordFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return teacherResetPasswordViewBodyBlocBuilder(
          state: state,
        );
      },
    );
  }
}
