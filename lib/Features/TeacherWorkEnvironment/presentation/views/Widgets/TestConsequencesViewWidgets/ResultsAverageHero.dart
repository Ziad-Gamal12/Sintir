import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

/// Presentational hero for the average score. No data fetching here.
class ResultsAverageHero extends StatelessWidget {
  const ResultsAverageHero({
    super.key,
    required this.label,
    required this.average,
    this.totalQuestions,
  });

  final String label;

  /// null → value not available: shows "—" with no percentage / bar.
  final double? average;

  /// If null or 0, the "/ total", percentage pill and bar are hidden.
  final int? totalQuestions;

  String get _averageText {
    final value = average;
    if (value == null) return '—';
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    final value = average;
    final total = totalQuestions ?? 0;
    final hasTotal = value != null && total > 0;
    final ratio = (value != null && total > 0)
        ? (value / total).clamp(0.0, 1.0).toDouble()
        : 0.0;
    final percent = (ratio * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          primary.withValues(alpha: isDark ? 0.06 : 0.04),
          theme.cardColor,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primary.withValues(alpha: isDark ? 0.22 : 0.28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context).semiBold12.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (hasTotal) _PercentPill(percent: percent, color: primary),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            // Force LTR so "1.5 / 3" never gets mirrored in RTL.
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _averageText,
                    style: AppTextStyles(context).bold24.copyWith(
                      fontSize: 34,
                      height: 1.0,
                      color: primary,
                    ),
                  ),
                  if (hasTotal)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 6),
                      child: Text(
                        '/ $total',
                        style: AppTextStyles(context).semiBold16.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (hasTotal) ...[
            const SizedBox(height: 14),
            _ProgressBar(value: ratio, color: primary),
          ],
        ],
      ),
    );
  }
}

class _PercentPill extends StatelessWidget {
  const _PercentPill({required this.percent, required this.color});

  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        '$percent%',
        style: AppTextStyles(context).semiBold12.copyWith(color: color),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: Stack(
            // Directional alignment → fills from the right in RTL.
            children: [
              Container(height: 8, color: color.withValues(alpha: 0.14)),
              FractionallySizedBox(
                widthFactor: v,
                child: Container(height: 8, color: color),
              ),
            ],
          ),
        );
      },
    );
  }
}
