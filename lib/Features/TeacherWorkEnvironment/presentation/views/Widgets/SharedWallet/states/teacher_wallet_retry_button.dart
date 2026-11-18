import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

/// Compact localized "Retry" action used by the wallet's failure states.
class TeacherWalletRetryButton extends StatelessWidget {
  const TeacherWalletRetryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: primary,
        minimumSize: const Size(0, 36),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(Icons.refresh_rounded, size: 18),
      label: Text(
        LocaleKeys.walletRetry,
        style: AppTextStyles(context).semiBold12.copyWith(color: primary),
      ),
    );
  }
}
