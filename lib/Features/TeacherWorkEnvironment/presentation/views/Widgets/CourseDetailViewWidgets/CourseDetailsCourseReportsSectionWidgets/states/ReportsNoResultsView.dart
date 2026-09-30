import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class ReportsNoResultsView extends StatelessWidget {
  const ReportsNoResultsView({super.key, required this.onClear});
  final VoidCallback onClear;
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.search_off,
                size: 42,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 10),
            Text(LocaleKeys.reportNoResults,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            OutlinedButton(
                onPressed: onClear, child: Text(LocaleKeys.reportClearFilters)),
          ])));
}
