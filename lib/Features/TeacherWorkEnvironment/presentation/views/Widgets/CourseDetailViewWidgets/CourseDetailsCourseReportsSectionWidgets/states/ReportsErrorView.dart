import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class ReportsErrorView extends StatelessWidget {
  const ReportsErrorView(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.cloud_off_outlined,
                size: 42, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 10),
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(LocaleKeys.reportRetry)),
          ])));
}
