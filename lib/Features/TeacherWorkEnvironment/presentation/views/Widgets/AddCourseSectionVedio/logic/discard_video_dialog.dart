import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

Future<bool> showDiscardVideoDialog(BuildContext context) async {
  final styles = AppTextStyles(context);
  final shouldDiscard = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(LocaleKeys.discardVideoTitle, style: styles.bold16),
      content: Text(LocaleKeys.discardVideoMessage, style: styles.regular14),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(LocaleKeys.cancel, style: styles.semiBold14),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(LocaleKeys.discardChanges, style: styles.semiBold14),
        ),
      ],
    ),
  );
  return shouldDiscard ?? false;
}
