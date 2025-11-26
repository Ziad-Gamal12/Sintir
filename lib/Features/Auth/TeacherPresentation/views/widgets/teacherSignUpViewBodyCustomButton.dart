// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherSignUpButton extends StatelessWidget {
  const TeacherSignUpButton({
    super.key,
    required this.isChecked,
    required this.formKey,
    required this.teacherSignUpPasswordController,
  });

  final bool isChecked;
  final GlobalKey<FormState> formKey;
  final TextEditingController teacherSignUpPasswordController;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
      text: LocaleKeys.createAccount,
      color: KMainColor,
      textColor: Colors.white,
      onPressed: () {
        if (!formKey.currentState!.validate()) return;

        final cubit = context.read<TeacherSignUpCubit>();
        final user = context.read<UserEntity>();
        user.fullName = "${user.firstName} ${user.lastName}";

        final subject = user.teacherExtraDataEntity?.subject ?? "";
        if (subject.isEmpty) {
          errordialog(context, LocaleKeys.mustChooseSubject).show();
          return;
        }

        if (!isChecked) {
          errordialog(context, LocaleKeys.mustAcceptTerms).show();
          return;
        }
        cubit.createUserWithEmailAndPassword(
          userentity: user,
          password: teacherSignUpPasswordController.text,
        );
      },
    );
  }
}
