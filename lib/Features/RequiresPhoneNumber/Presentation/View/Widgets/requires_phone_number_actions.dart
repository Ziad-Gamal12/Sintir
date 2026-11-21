import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/Manager/UpdateUserPhoneNumberCubit/update_user_phone_number_cubit.dart';
import 'package:sintir/locale_keys.dart';

class RequiresPhoneNumberActions extends StatelessWidget {
  const RequiresPhoneNumberActions({
    super.key,
    required this.isDesktop,

    required this.formKey,
    required this.phoneController,
    required this.uid,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final String uid;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const primaryBlue = Color(0xFF3B66F5);
    final mutedTextColor = theme.colorScheme.onSurface.withValues(alpha: 0.65);

    final primaryButton = SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (!(formKey.currentState?.validate() ?? false)) return;
          final phone = phoneController.text.trim();
          log(phone);

          context.read<UpdateUserPhoneNumberCubit>().updatePhoneNumber(
            phoneNumber: phone,
            uid: uid,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.saveAndContinueSubscription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            BlocSelector<
              UpdateUserPhoneNumberCubit,
              UpdateUserPhoneNumberState,
              bool
            >(
              selector: (state) {
                return state is UpdateUserPhoneNumberLoading;
              },
              builder: (context, isLoading) {
                if (isLoading) {
                  return SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ),
                  );
                } else {
                  return const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: primaryButton),
          const SizedBox(width: 12),
          SizedBox(
            height: 52,
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.07)
                    : const Color(0xFFF1F5F9),
                foregroundColor: mutedTextColor,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                LocaleKeys.goBack,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: mutedTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        primaryButton,
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: mutedTextColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            LocaleKeys.goBack,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: mutedTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
