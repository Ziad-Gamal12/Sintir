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
        icon: Icon(Icons.highlight_off, size: 32, color: Colors.red),
        title: Text(LocaleKeys.reportDismissConfirmTitle),
        content: Text(LocaleKeys.reportDismissConfirmBody),
        actions: [
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.red),
              child: Text(
                LocaleKeys.reportDismissAction,
                style:
                    AppTextStyles(context).bold16.copyWith(color: Colors.white),
              )),
          Center(
            child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(LocaleKeys.cancel)),
          ),
        ],
      );
}
