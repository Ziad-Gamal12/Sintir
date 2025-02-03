// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpViewBody.dart';

class TeacherSignUpView extends StatelessWidget {
  const TeacherSignUpView({super.key});
  static const routeName = "/TeacherSignUpView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherSignUpCubit(
          getIt<TeacherAuthRepos>(), getIt<Pickerassetsservice>()),
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "انشاء حساب"),
        body: TeacherSignUpViewBody(),
      ),
    );
  }
}
