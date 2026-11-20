// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Enums/SiginInMethod.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Repos/ProfileCompletionRepo.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Manager/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileViewBody.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key, required this.method});
  static const routeName = '/complete-profile';
  final SiginInMethod? method;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteProfileCubit(repo: getIt<ProfileCompletionRepo>()),
      child: Scaffold(
        body: SafeArea(child: CompleteProfileViewBody(method: method)),
      ),
    );
  }
}
