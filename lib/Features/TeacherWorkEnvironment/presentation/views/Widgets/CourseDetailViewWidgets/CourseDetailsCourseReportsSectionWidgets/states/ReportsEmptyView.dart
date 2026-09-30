import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class ReportsEmptyView extends StatelessWidget {
  const ReportsEmptyView({super.key, required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.inbox_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(LocaleKeys.reportEmptyTitle,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(LocaleKeys.reportEmptySubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(LocaleKeys.reportRetry)),
          ])));
}
