import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/Custom_reset_password_cubit/Custom_reset_password_cubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class CustomResetPasswordViewBodyActionButton extends StatelessWidget {
  const CustomResetPasswordViewBodyActionButton({
    super.key,
    required this.resetPasswordFormKey,
    required this.emailController,
  });

  final GlobalKey<FormState> resetPasswordFormKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "نسيت كلمة المرور",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (resetPasswordFormKey.currentState!.validate()) {
            context
                .read<CustomResetPasswordCubit>()
                .sendResetPasswordEmail(email: emailController.text);
          }
        });
  }
}
