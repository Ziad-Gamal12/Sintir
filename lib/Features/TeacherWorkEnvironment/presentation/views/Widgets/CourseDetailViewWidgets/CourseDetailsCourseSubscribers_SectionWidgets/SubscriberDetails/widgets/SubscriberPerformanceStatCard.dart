import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SubscriberPerformanceStatCard extends StatelessWidget {
  const SubscriberPerformanceStatCard({
    super.key,
    required this.label,
    required this.average,
    required this.highlight,
    required this.averageValue,
    required this.valueColor,
    this.result,
  });

  final String label;
  final bool average;
  final bool highlight;
  final double averageValue;
  final Color valueColor;
  final TestResultEntity? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = AppTextStyles(context);
    final accent = valueColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: highlight
            ? theme.colorScheme.primary.withValues(alpha: .08)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: highlight
              ? theme.colorScheme.primary.withValues(alpha: .5)
              : theme.dividerColor.withValues(alpha: .45),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (average)
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                averageValue.toStringAsFixed(2),
                style: textStyle.semiBold16.copyWith(color: accent),
              ),
            )
          else
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text.rich(
                TextSpan(
                  text: '${result?.result ?? 0}',
                  style: textStyle.semiBold14.copyWith(color: accent),
                  children: [
                    TextSpan(
                      text: ' / ${result?.totalQuestions ?? 0}',
                      style: textStyle.regular12.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle.regular11.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
