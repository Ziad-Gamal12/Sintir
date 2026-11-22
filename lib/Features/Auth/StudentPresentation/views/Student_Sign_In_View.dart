// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthBrandPanel.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthShell.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/StudentSignIn_Cubit/student_sign_in_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignInViewBody.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignInView extends StatelessWidget {
  const StudentSignInView({super.key});
  static const routeName = '/Student_Sign_In_View';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignInCubit(getIt<AuthRepo>()),
      child: AuthShell(
        title: LocaleKeys.login,
        illustration: Assets.assetsImagesSVGImagesLoginWelcomeImage,
        headline: const SintirWelcomeTitle(),
        subtitle: LocaleKeys.loginToContinue,
        badge: AuthRoleBadge(
          label: LocaleKeys.studentRole,
          icon: Icons.school_outlined,
        ),
        brand: AuthBrandContent(
          title: LocaleKeys.startLearningJourneyTitle,
          description: LocaleKeys.description3,
        ),
        child: const StudentSignInViewBody(),
      ),
    );
  }
}
