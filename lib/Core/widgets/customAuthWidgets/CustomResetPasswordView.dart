// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/repos/ResetPaswordRepo/ResetPaswordRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBody.dart';
import 'package:sintir/locale_keys.dart';

class CustomResetPasswordView extends StatelessWidget {
  const CustomResetPasswordView({super.key});
  static const routeName = '/teacherResetPasswordView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomResetPasswordCubit(authrepo: getIt<ResetPaswordRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.resetPassword),
        body: const CustomResetPasswordViewBody(),
      ),
    );
  }
}
