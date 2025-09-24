// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/constant.dart';

class teacherSignUpViewBodyCustomButton extends StatelessWidget {
  const teacherSignUpViewBodyCustomButton(
      {super.key,
      required this.isChecked,
      required this.teacherSignUpPasswordController,
      required this.formKey});

  final bool isChecked;
  final GlobalKey<FormState> formKey;
  final TextEditingController teacherSignUpPasswordController;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "انشاء حساب",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            context.read<UserEntity>().fullName =
                "${context.read<UserEntity>().firstName} ${context.read<UserEntity>().lastName}";
            if (isChecked) {
              BlocProvider.of<TeacherSignUpCubit>(context)
                  .createUserWithEmailAndPassword(
                userentity: context.read<UserEntity>(),
                password: teacherSignUpPasswordController.text,
              );
            } else {
              errordialog(context, "قم بقبول الشروط والاحكام").show();
            }
          }
        });
  }
}
