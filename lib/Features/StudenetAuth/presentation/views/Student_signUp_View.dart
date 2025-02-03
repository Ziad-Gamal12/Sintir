// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignupViewBody.dart';

class StudentSignupView extends StatelessWidget {
  const StudentSignupView({super.key});
  static const routeName = "/StudentSignupView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignUpCubit(getIt<StudentauthRepo>()),
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "انشاء حساب"),
        body: StudentSignupViewBody(),
      ),
    );
  }
}
