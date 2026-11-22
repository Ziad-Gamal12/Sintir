// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthBrandPanel.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthShell.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSigninViewBody.dart';
import 'package:sintir/locale_keys.dart';

class TeacherSignInView extends StatelessWidget {
  static const routeName = "/TeacherLoginView";
  const TeacherSignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherSignInCubit(authrepo: getIt<AuthRepo>()),
      child: AuthShell(
        title: LocaleKeys.login,
        illustration: Assets.assetsImagesSVGImagesLoginWelcomeImage,
        headline: const SintirWelcomeTitle(),
        subtitle: LocaleKeys.loginToContinue,
        badge: AuthRoleBadge(
          label: LocaleKeys.teacherRole,
          icon: Icons.cast_for_education_outlined,
        ),
        brand: AuthBrandContent(
          title: LocaleKeys.teacherFeaturesTitle,
          description: LocaleKeys.teacherFeaturesDescription,
        ),
        child: const TeacherSigninViewBody(),
      ),
    );
  }
}
