import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class ReportDetailEmptyView extends StatelessWidget {
  const ReportDetailEmptyView({super.key});
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.description_outlined,
                size: 42,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(LocaleKeys.reportSelectPrompt,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ])));
}
