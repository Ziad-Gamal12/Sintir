// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignUpViewBodyBlocBuilder_button extends StatelessWidget {
  const StudentSignUpViewBodyBlocBuilder_button({
    super.key,
    required this.isTermsAndConditionChecked,
    required this.stundentSignUpFormKey,
    required this.studentSignUpPasswordController,
  });
  final GlobalKey<FormState> stundentSignUpFormKey;
  final bool isTermsAndConditionChecked;
  final TextEditingController studentSignUpPasswordController;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: LocaleKeys.createAccount,
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (stundentSignUpFormKey.currentState != null) {
            if (stundentSignUpFormKey.currentState!.validate()) {
              stundentSignUpFormKey.currentState!.save();
              context.read<UserEntity>().fullName =
                  "${context.read<UserEntity>().firstName} ${context.read<UserEntity>().lastName}";
              if (isTermsAndConditionChecked) {
                BlocProvider.of<StudentSignUpCubit>(context)
                    .createUserWithEmailAndPassword(
                  userEntity: context.read<UserEntity>(),
                  password: studentSignUpPasswordController.text,
                );
              } else {
                errordialog(context, LocaleKeys.agreeTerms).show();
              }
            }
          } else {
            errordialog(context, LocaleKeys.errorOccurredMessage).show();
          }
        });
  }
}
