// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyBlocBuilder.dart';
import 'package:sintir/locale_keys.dart';

class CustomResetPasswordViewBody extends StatelessWidget {
  const CustomResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomResetPasswordCubit, CustomResetPasswordState>(
      listener: (context, state) {
        if (state is CustomResetPasswordSuccess) {
          successdialog(
            context: context,
            SuccessMessage: LocaleKeys.successEmailSent,
            btnOkOnPress: () {
              GoRouter.of(context).pop();
            },
          ).show();
        } else if (state is CustomResetPasswordFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return const CustomResetPasswordViewBodyBlocBuilder();
      },
    );
  }
}
