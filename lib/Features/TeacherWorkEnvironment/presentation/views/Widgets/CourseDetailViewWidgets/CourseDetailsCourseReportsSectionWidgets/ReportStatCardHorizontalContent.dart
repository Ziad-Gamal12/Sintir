import 'package:flutter/material.dart';

class ReportStatCardHorizontalContent extends StatelessWidget {
  const ReportStatCardHorizontalContent({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.accent,
    required this.titleColor,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color accent;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                      color: titleColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '$count',
                    style: textTheme.headlineSmall?.copyWith(
                        color: accent,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.14),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
        ],
      ),
    );
  }
}
