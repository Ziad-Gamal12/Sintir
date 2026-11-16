import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ReportDismissConfirmDialog extends StatelessWidget {
  const ReportDismissConfirmDialog({super.key});
  static Future<bool> confirm(BuildContext context) async =>
      await showAdaptiveDialog<bool>(
        context: context,
        builder: (_) => const ReportDismissConfirmDialog(),
      ) ??
      false;
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      LocaleKeys.reportDismissConfirmTitle,
      textAlign: TextAlign.center,
    ),
    content: Text(
      LocaleKeys.reportDismissConfirmBody,
      textAlign: TextAlign.center,
    ),
    actions: [
      FilledButton(
        onPressed: () => Navigator.pop(context, true),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.red,
        ),
        child: Text(
          LocaleKeys.reportDismissAction,
          style: AppTextStyles(context).bold16.copyWith(color: Colors.white),
        ),
      ),
      Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            LocaleKeys.cancel,
            style: AppTextStyles(context).semiBold16.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(0xCC),
            ),
          ),
        ),
      ),
    ],
  );
}
