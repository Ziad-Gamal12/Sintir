// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/BlocBuilder/teacherSignUpViewBodyBlocBuilder.dart';

class TeacherSignUpViewBody extends StatelessWidget {
  const TeacherSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
      listener: (context, state) {
        if (state is TeacherSignUpSuccess) {
          successdialog(
              context: context,
              SuccessMessage:
                  "تم ارسال طلب انضمامك بنجاح\nسيتم التواصل معك في اقرب وقت!",
              btnOkOnPress: () {
                GoRouter.of(context).pop();
              }).show();
        } else if (state is TeacherSignUpFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return teacherSignUpViewBodyBlocBuilder(
          state: state,
          width: width,
        );
      },
    );
  }
}
