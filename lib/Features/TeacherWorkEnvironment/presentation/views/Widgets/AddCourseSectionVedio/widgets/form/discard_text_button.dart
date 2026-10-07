import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class DiscardTextButton extends StatelessWidget {
  const DiscardTextButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(48, 48),
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      child: Text(
        LocaleKeys.discardAndGoBack,
        style: AppTextStyles(context).semiBold14,
      ),
    );
  }
}
