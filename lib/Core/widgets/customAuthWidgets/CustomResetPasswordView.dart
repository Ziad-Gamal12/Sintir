// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Cusbits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/repos/authRepos/authrepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBody.dart';
import 'package:svg_flutter/svg.dart';

class CustomResetPasswordView extends StatelessWidget {
  const CustomResetPasswordView({super.key});
  static const routeName = '/teacherResetPasswordView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomResetPasswordCubit(authrepo: getIt<Authrepo>()),
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
            "استعاده كلمة المرور",
            style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: const CustomResetPasswordViewBody(),
      ),
    );
  }
}
