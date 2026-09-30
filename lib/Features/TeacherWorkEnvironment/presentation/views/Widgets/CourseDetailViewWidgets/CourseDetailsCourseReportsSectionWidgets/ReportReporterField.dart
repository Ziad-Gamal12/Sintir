import 'package:flutter/material.dart';

class ReportReporterField extends StatelessWidget {
  const ReportReporterField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.compact = false,
    this.alignEnd = false,
  });
  final IconData icon;
  final String label, value;
  final bool compact, alignEnd;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minWidth: compact ? 0 : 180),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,
                size: 17,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Flexible(
              child: Column(
                crossAxisAlignment: alignEnd
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(label,
                      textAlign: alignEnd ? TextAlign.end : TextAlign.start,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant)),
                  Text(value,
                      textAlign: alignEnd ? TextAlign.end : TextAlign.start,
                      maxLines: compact ? 2 : null,
                      overflow: compact ? TextOverflow.ellipsis : null,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      );
}
