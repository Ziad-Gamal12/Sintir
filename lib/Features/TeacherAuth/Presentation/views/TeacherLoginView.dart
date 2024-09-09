// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginViewBody.dart';

class TeacherLoginView extends StatelessWidget {
  static const String routeName = "/TeacherLoginView";

  const TeacherLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TeacherSignInCubit(teacherAuthRepos: getIt<TeacherAuthRepos>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          title: Text(
            "تسجيل الدخول",
            style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return const TeacherLoginViewBody();
        }),
      ),
    );
  }
}
