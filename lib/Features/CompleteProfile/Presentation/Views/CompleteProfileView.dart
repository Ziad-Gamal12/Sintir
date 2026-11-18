// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Repos/ProfileCompletionRepo.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Manager/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileViewBody.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key, required this.purpose});
  static const routeName = '/complete-profile';

  final CompleteProfilePurpose purpose;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteProfileCubit(repo: getIt<ProfileCompletionRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(
          appBartitle: LocaleKeys.completeProfileTitle,
          isPopUp: purpose == CompleteProfilePurpose.payment,
        ),
        body: SafeArea(
          top: false,
          child: CompleteProfileViewBody(purpose: purpose),
        ),
      ),
    );
  }
}
