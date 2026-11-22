// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/customStudentSocialButton.dart';
import 'package:sintir/locale_keys.dart';

class Student_SigninSocialbuttonssection extends StatelessWidget {
  const Student_SigninSocialbuttonssection({super.key});

  static const double _rowMinWidth = 420;

  @override
  Widget build(BuildContext context) {
    Widget google(String text) => Customstudentsocialbutton(
          text: text,
          onPressed: () {
            BlocProvider.of<StudentSignInCubit>(context).signInWithGoogle();
          },
          iconpath: Assets.assetsIconsSVGIconsGoogle,
        );
    Widget facebook(String text) => Customstudentsocialbutton(
          text: text,
          onPressed: () {
            BlocProvider.of<StudentSignInCubit>(context).signInWithFacebook();
          },
          iconpath: Assets.assetsIconsSVGIconsFaceBookIcons,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _rowMinWidth) {
          return Row(
            spacing: 12,
            children: [
              Expanded(child: google('Google')),
              Expanded(child: facebook('Facebook')),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            google(LocaleKeys.signInGoogle),
            facebook(LocaleKeys.signInFacebook),
          ],
        );
      },
    );
  }
}
