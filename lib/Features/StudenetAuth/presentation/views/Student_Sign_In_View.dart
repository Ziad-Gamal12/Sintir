// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignInViewBody.dart';

class StudentSignInView extends StatelessWidget {
  const StudentSignInView({super.key});
  static const routeName = '/Student_Sign_In_View';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignInCubit(getIt<StudentauthRepo>()),
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "تسجيل الدخول"),
        body: StudentSignInViewBody(),
      ),
    );
  }
}
