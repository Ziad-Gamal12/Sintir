import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsChart extends StatefulWidget {
  final List<TestResultEntity> results;

  const SubscriberResultsChart({super.key, required this.results});

  @override
  State<SubscriberResultsChart> createState() => _SubscriberResultsChartState();
}

class _SubscriberResultsChartState extends State<SubscriberResultsChart> {
  // Toggle: false = Individual Scores, true = Average Line
  bool showAverage = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color chartBackgroundColor = theme.cardColor;
    final Color gridColor = theme.dividerColor.withOpacity(0.5);
    final Color mainColor = theme.colorScheme.primary;

    if (widget.results.isEmpty) {
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
    List<TestResultEntity> recentResults = widget.results.reversed.toList();
    List<TestResultEntity> displayedResults = recentResults.length > 6
        ? recentResults
            .sublist(0, 6)
            .reversed // Get last 6, then reverse to original chronological order
            .toList()
        : recentResults.reversed.toList(); // Use all if 6 or less

    // Values for plotting
    final List<double> values =
        displayedResults.map((e) => (e.result ?? 0).toDouble()).toList();

    // Calculate max value for Y-axis (adds padding of 5 above the highest score)
    // Ensures maxY is at least 10 if all scores are low/zero.
    final double maxScoreValue =
        values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 0;

    // Y-Axis Maximum: Ensure it ends nicely on a multiple of 5 (the interval)
    double calculatedMaxY = maxScoreValue + 5;
    calculatedMaxY = (calculatedMaxY / 5).ceil() * 5.0;
    final double chartMaxY = showAverage
        ? (values.isNotEmpty
            ? (values.reduce((a, b) => a > b ? a : b) + 5)
                .clamp(10, double.infinity)
            : 10)
        : calculatedMaxY;

    // Calculate average value of the displayed results
    final double avgValue = values.isNotEmpty
        ? values.reduce((a, b) => a + b) / values.length
        : 0.0;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => setState(() => showAverage = !showAverage),
            icon: Icon(
                showAverage ? Icons.show_chart : Icons.stacked_line_chart,
                color: mainColor),
            // Corrected button text for clarity:
            label: Text(
                showAverage ? LocaleKeys.results : LocaleKeys.averageResults,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: mainColor)),
          ),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: chartBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              left: 8,
              right: 30,
              top: 15,
              bottom: 8,
            ),
            child: LineChart(
              LineChartData(
                // X-axis configuration
                minX: 0,
                maxX: (values.length - 1).toDouble().clamp(0, double.infinity),

                // Y-axis configuration
                minY: 0,
                // Use the calculated maximum Y for better fit and interval alignment
                maxY: chartMaxY,

                // Grid Lines
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 5, // Interval remains 5
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: gridColor,
                    strokeWidth: 1,
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
                      reservedSize: 20,
                      getTitlesWidget: (value, meta) => Text(
                        // Displaying 'Attempt 1', 'Attempt 2', etc.
                        "${LocaleKeys.attempt} ${value.toInt() + 1}",
                        style: AppTextStyles(context)
                            .regular11
                            .copyWith(color: secondaryTextColor),
                      ),
                    ),
                  ),

                  // Left Titles (Score value)
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
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
                    isCurved:
                        !showAverage, // Only curve if showing individual scores
                    barWidth: 3,

                    // Spots data: show average line or individual scores
                    spots: showAverage
                        ? [
                            FlSpot(0, avgValue),
                            FlSpot(
                                (values.length - 1)
                                    .toDouble()
                                    .clamp(0, double.infinity),
                                avgValue)
                          ]
                        : List.generate(values.length,
                            (i) => FlSpot(i.toDouble(), values[i])),

                    color: showAverage ? Colors.redAccent : mainColor,
                    gradient: showAverage
                        ? null
                        : LinearGradient(
                            colors: [mainColor, mainColor.withOpacity(0.7)],
                          ),

                    // Area below the line
                    belowBarData: BarAreaData(
                      show:
                          !showAverage, // Only show area for individual scores
                      gradient: LinearGradient(
                        colors: [
                          mainColor.withOpacity(0.3),
                          mainColor.withOpacity(0.05)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),

                    // Dots on the line
                    dotData: FlDotData(
                        show:
                            !showAverage), // Only show dots for individual scores
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
                            showAverage
                                ? "${LocaleKeys.averageResults}: ${spot.y.toStringAsFixed(1)}"
                                : "${LocaleKeys.attempt}: ${spot.x.toInt() + 1}\n ${LocaleKeys.studentScore}: ${spot.y.toStringAsFixed(1)}",
                            TextStyle(color: chartBackgroundColor),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
