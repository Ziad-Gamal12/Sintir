import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_chart_axis_titles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberChartData {
  const SubscriberChartData._();

  static LineChartData build({
    required BuildContext context,
    required List<int> values,
    required int totalCount,
    required ResultsTokens tokens,
    required AppTextStyles styles,
    required String locale,
  }) => LineChartData(
    minX: 0,
    maxX: values.length < 2 ? 1 : (values.length - 1).toDouble(),
    minY: 0,
    maxY: 100,
    clipData: const FlClipData.none(),
    gridData: FlGridData(
      drawVerticalLine: false,
      horizontalInterval: 50,
      getDrawingHorizontalLine: (_) =>
          FlLine(color: tokens.track, strokeWidth: 1, dashArray: [4, 4]),
    ),
    titlesData: SubscriberChartAxisTitles.build(
      visibleCount: values.length,
      totalCount: totalCount,
      locale: locale,
      tokens: tokens,
      styles: styles,
    ),
    borderData: FlBorderData(show: false),
    lineBarsData: [
      LineChartBarData(
        spots: [
          for (var i = 0; i < values.length; i++)
            FlSpot(i.toDouble(), values[i].toDouble()),
        ],
        isCurved: values.length > 2,
        color: tokens.primary,
        barWidth: 3,
        dotData: FlDotData(
          getDotPainter: (_, _, _, _) => FlDotCirclePainter(
            radius: 4.5,
            color: tokens.card,
            strokeWidth: 2,
            strokeColor: tokens.primary,
          ),
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              tokens.primary.withValues(alpha: .22),
              tokens.primary.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    ],
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (spots) => spots
            .map(
              (spot) => LineTooltipItem(
                LocaleKeys.subscriberChartTooltip(
                  totalCount - values.length + spot.x.round() + 1,
                  spot.y.round(),
                  locale,
                ),
                styles.regular12.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
