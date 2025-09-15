// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/BlocBuilder/teacherSignUpViewBodyBlocBuilder.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherAuthListeners/teacherBlocListenerMethods.dart';

class TeacherSignUpViewBody extends StatelessWidget {
  const TeacherSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
      listener: (context, state) {
        teacherSignUpListener(context, state);
      },
      builder: (context, state) {
        return const teacherSignUpViewBodyBlocBuilder();
      },
    );
  }
}
