// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignInViewBody.dart';
import 'package:svg_flutter/svg.dart';

class StudentSignInView extends StatelessWidget {
  const StudentSignInView({super.key});
  static const routeName = '/Student_Sign_In_View';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignInCubit(getIt<StudentauthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: SvgPicture.asset(
                Assets.assetsImagesArrowLeftBack,
                height: 30,
                width: 30,
              )),
          title: Text(
            "تسجيل الدخول",
            style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: const StudentSignInViewBody(),
      ),
    );
  }
}
