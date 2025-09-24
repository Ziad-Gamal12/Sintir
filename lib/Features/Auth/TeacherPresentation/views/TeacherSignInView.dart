// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSigninViewBody.dart';

class TeacherSignInView extends StatelessWidget {
  static const routeName = "/TeacherLoginView";
  const TeacherSignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherSignInCubit(authrepo: getIt<AuthRepo>()),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "تسجيل الدخول"),
        body: Builder(builder: (context) {
          return const TeacherSigninViewBody();
        }),
      ),
    );
  }
}
