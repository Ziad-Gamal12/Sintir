// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/BlocBuilder_section/StundetSignUpViewBody_BlocBuilder.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignupViewBody extends StatelessWidget {
  const StudentSignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentSignUpCubit, StudentSignUpState>(
      listener: (context, state) {
        if (state is StudentSignUpSuccess) {
          successdialog(
              context: context,
              SuccessMessage: LocaleKeys.accountCreatedSuccessfully,
              btnOkOnPress: () {
                GoRouter.of(context).pop();
              }).show();
        } else if (state is StudentSignUpFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return StundetSignUpViewBody_BlocBuilder(
          state: state,
        );
      },
    );
  }
}
