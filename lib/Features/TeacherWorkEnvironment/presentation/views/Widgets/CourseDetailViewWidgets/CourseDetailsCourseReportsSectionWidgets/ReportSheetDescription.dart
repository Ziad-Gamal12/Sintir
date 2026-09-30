import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

import 'utils/report_surface_colors.dart';

class ReportSheetDescription extends StatelessWidget {
  const ReportSheetDescription({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.reportFullText,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.reportPanelFill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.reportPanelBorder),
          ),
          child: SelectableText(
            text,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyMedium
                ?.copyWith(height: 1.7, color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}
