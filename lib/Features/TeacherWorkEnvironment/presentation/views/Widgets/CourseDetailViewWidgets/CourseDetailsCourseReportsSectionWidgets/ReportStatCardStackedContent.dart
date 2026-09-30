import 'package:flutter/material.dart';

class ReportStatCardStackedContent extends StatelessWidget {
  const ReportStatCardStackedContent({
    super.key,
    required this.title,
    required this.caption,
    required this.count,
    required this.accent,
    required this.titleColor,
    required this.captionColor,
  });

  final String title;
  final String caption;
  final int count;
  final Color accent;
  final Color titleColor;
  final Color captionColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
                color: titleColor, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$count',
              style: textTheme.headlineSmall?.copyWith(
                  color: accent,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.1),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall
                ?.copyWith(color: captionColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
