import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';

class SubscriberResultsChart extends StatelessWidget {
  final List<TestResultEntity> results;
  final SubscriberPerformanceSummary summary;

  const SubscriberResultsChart({
    super.key,
    required this.results,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color chartBackgroundColor = theme.cardColor;
    final Color gridColor = theme.dividerColor.withValues(alpha: 0.5);
    final Color mainColor = theme.colorScheme.primary;

    if (results.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.noResults,
          style: AppTextStyles(context)
              .regular16
              .copyWith(color: secondaryTextColor),
        ),
      );
    }

    // Use the last 6 results for the chart visualization (most recent attempts)
    // We reverse the list to get the most recent, then reverse back to chronological order for the chart (x-axis)
    List<TestResultEntity> recentResults = results.reversed.toList();
    List<TestResultEntity> displayedResults = recentResults.length > 6
        ? recentResults
            .sublist(0, 6)
            .reversed // Get last 6, then reverse to original chronological order
            .toList()
        : recentResults.reversed.toList(); // Use all if 6 or less

    // Values for plotting
    final int firstIndex = results.length - displayedResults.length;
    final List<double> values = List.generate(displayedResults.length, (index) {
      final summaryIndex = firstIndex + index;
      return summaryIndex < summary.normalizedScores.length
          ? summary.normalizedScores[summaryIndex]
          : 0;
    });

    // Calculate max value for Y-axis (adds padding of 5 above the highest score)
    // Ensures maxY is at least 10 if all scores are low/zero.
    // Y-Axis Maximum: Ensure it ends nicely on a multiple of 5 (the interval)
    const double chartMaxY = 1;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: chartBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
              border:
                  Border.all(color: theme.dividerColor.withValues(alpha: .5)),
            ),
            padding: const EdgeInsets.only(
              left: 8,
              right: 12,
              top: 15,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys.examScoreProgression,
                  textAlign: TextAlign.end,
                  style: AppTextStyles(context).semiBold14.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Expanded(
                    child: LineChart(LineChartData(
                  // X-axis configuration
                  minX: 0,
                  maxX: values.length < 2 ? 1 : (values.length - 1).toDouble(),

                  // Y-axis configuration
                  minY: 0,
                  // Use the calculated maximum Y for better fit and interval alignment
                  maxY: chartMaxY,

                  // Grid Lines
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 0.5,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: gridColor,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: gridColor,
                      strokeWidth: 1,
                    ),
                  ),

                  // Axis Titles
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),

                    // Bottom Titles (Attempt number)
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 34,
                        getTitlesWidget: (value, meta) => Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            "${LocaleKeys.attempt} ${value.toInt() + 1}",
                            style: AppTextStyles(context)
                                .regular11
                                .copyWith(color: secondaryTextColor),
                          ),
                        ),
                      ),
                    ),

                    // Left Titles (Score value)
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 0.5,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text(
                          '${(value * 100).round()}%',
                          style: AppTextStyles(context)
                              .regular11
                              .copyWith(color: secondaryTextColor),
                        ),
                      ),
                    ),
                  ),

                  borderData: FlBorderData(show: false),

                  // Data Lines
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: values.length > 2,
                      barWidth: 3,

                      spots: List.generate(values.length,
                          (i) => FlSpot(i.toDouble(), values[i])),

                      color: mainColor,

                      // Area below the line
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            mainColor.withValues(alpha: 0.22),
                            mainColor.withValues(alpha: 0.0)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),

                      // Dots on the line
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                          radius: 4,
                          color: chartBackgroundColor,
                          strokeWidth: 2,
                          strokeColor: mainColor,
                        ),
                      ),
                    ),
                  ],

                  // Tooltip when touching the chart
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) => touchedSpots
                          .map(
                            (spot) => LineTooltipItem(
                              // Display either the score or the average value
                              "${LocaleKeys.attempt}: ${spot.x.toInt() + 1}\n${LocaleKeys.studentScore}: ${(spot.y * 100).toStringAsFixed(0)}%",
                              AppTextStyles(context).regular12.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
