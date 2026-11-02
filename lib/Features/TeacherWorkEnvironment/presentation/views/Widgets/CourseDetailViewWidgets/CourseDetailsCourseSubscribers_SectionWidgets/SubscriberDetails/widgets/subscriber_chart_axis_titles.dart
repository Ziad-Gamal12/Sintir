import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberChartAxisTitles {
  const SubscriberChartAxisTitles._();

  static FlTitlesData build({
    required int visibleCount,
    required int totalCount,
    required String locale,
    required ResultsTokens tokens,
    required AppTextStyles styles,
  }) =>
      FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            reservedSize: 42,
            getTitlesWidget: (value, _) => Text(
              '${LocaleFormatter.number(value.round(), locale)}%',
              style: styles.regular11.copyWith(
                color: tokens.muted,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: Text(
            LocaleKeys.subscriberAttempt,
            style: styles.regular11.copyWith(color: tokens.muted),
          ),
          axisNameSize: 18,
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: (value, _) {
              final index = value.round();
              if (index < 0 || index >= visibleCount) {
                return const SizedBox.shrink();
              }
              final attempt = totalCount - visibleCount + index + 1;
              final number = LocaleFormatter.number(attempt, locale);
              final label = visibleCount <= 3
                  ? '${LocaleKeys.subscriberAttempt} $number'
                  : number;
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  label,
                  maxLines: 1,
                  style: styles.regular11.copyWith(
                    color: tokens.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
