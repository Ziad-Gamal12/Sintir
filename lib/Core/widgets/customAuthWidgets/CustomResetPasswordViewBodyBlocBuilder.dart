// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/Managers/Cubits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyActionButton.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordViewBodyDescription.dart';
import 'package:sintir/constant.dart';

class CustomResetPasswordViewBodyBlocBuilder extends StatefulWidget {
  const CustomResetPasswordViewBodyBlocBuilder({
    super.key,
    required this.state,
  });
  final CustomResetPasswordState state;

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
    return Form(
      key: resetPasswordFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: Column(
          children: [
            const CustomResetPasswordViewBodyDescription(),
            const Customsizedbox(width: 0, height: 20),
            CustomEmailTextField(
              controller: emailController,
              isIconVisible: true,
            ),
            const Customsizedbox(width: 0, height: 20),
            Custom_Loading_Widget(
              isLoading:
                  widget.state is CustomResetPasswordLoading ? true : false,
              child: CustomResetPasswordViewBodyActionButton(
                  resetPasswordFormKey: resetPasswordFormKey,
                  emailController: emailController),
            ),
            const Spacer(),
            Text(
              "تسجيل الدخول؟",
              style: AppTextStyles.semiBold16.copyWith(color: KMainColor),
            ),
          ],
        ),
      ),
    );
  }
}
