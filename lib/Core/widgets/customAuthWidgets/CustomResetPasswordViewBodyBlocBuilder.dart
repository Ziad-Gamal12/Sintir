// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyActionButton.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyDescription.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyPopUpButton.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class CustomResetPasswordViewBodyBlocBuilder extends StatefulWidget {
  const CustomResetPasswordViewBodyBlocBuilder({
    super.key,
  });

  @override
  State<CustomResetPasswordViewBodyBlocBuilder> createState() =>
      _CustomResetPasswordViewBodyBlocBuilderState();
}

class _CustomResetPasswordViewBodyBlocBuilderState
    extends State<CustomResetPasswordViewBodyBlocBuilder> {
  late GlobalKey<FormState> resetPasswordFormKey;
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    resetPasswordFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CustomResetPasswordCubit, CustomResetPasswordState,
        bool>(
      selector: (state) {
        return state is CustomResetPasswordLoading;
      },
      builder: (context, state) {
        return Form(
          key: resetPasswordFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KHorizontalPadding, vertical: KVerticalPadding),
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 2.5 / 2,
                    child: SvgPicture.asset(
                        Assets.assetsImagesSVGImagesForgetPasswordWelcomeImage),
                  ),
                ),
                const SizedBox(height: 40),
                const CustomResetPasswordViewBodyDescription(),
                const SizedBox(height: 40),
                CustomEmailTextField(
                  controller: emailController,
                  isIconVisible: true,
                ),
                const SizedBox(height: 40),
                Custom_Loading_Widget(
                  isLoading: state,
                  child: CustomResetPasswordViewBodyActionButton(
                      resetPasswordFormKey: resetPasswordFormKey,
                      emailController: emailController),
                ),
                const Spacer(),
                const CustomResetPasswordViewBodyPopUpButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
