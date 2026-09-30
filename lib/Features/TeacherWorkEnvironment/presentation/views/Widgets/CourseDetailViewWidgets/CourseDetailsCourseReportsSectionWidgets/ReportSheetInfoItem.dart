import 'package:flutter/material.dart';

class ReportSheetInfoItem extends StatelessWidget {
  const ReportSheetInfoItem({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
  });
  final String label;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: muted, fontSize: 12)),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(icon, size: 16, color: muted),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13, fontWeight: FontWeight.w700, height: 1.35),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
