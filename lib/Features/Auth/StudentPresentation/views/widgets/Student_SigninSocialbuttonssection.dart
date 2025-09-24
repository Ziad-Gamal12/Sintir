// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/customStudentSocialButton.dart';

class Student_SigninSocialbuttonssection extends StatelessWidget {
  const Student_SigninSocialbuttonssection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Customstudentsocialbutton(
          text: "تسجيل بواسطة جوجل",
          onPressed: () {
            BlocProvider.of<StudentSignInCubit>(context).signInWithGoogle();
          },
          iconpath: Assets.assetsImagesGoogle,
        ),
        const Customsizedbox(width: 0, height: 16),
        Customstudentsocialbutton(
          text: "تسجيل بواسطة فيسبوك",
          onPressed: () {
            BlocProvider.of<StudentSignInCubit>(context).signInWithFacebook();
          },
          iconpath: Assets.assetsImagesFaceBookIcons,
        ),
      ],
    );
  }
}
