import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ReportSheetDescription extends StatelessWidget {
  const ReportSheetDescription({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = AppTextStyles(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.reportFullText,
          style: style.semiBold16.copyWith(color: scheme.onSurface),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.onSurface.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
          ),
          child: SelectableText(
            text,
            style: style.regular14.copyWith(
              height: 1.7,
              color: scheme.onSurface.withValues(alpha: 0.92),
            ),
          ),
        ),
      ],
    );
  }
}
