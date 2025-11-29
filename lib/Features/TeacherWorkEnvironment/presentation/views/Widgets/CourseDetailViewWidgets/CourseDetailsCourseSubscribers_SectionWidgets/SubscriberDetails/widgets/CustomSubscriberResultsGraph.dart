import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsChart extends StatefulWidget {
  final List<TestResultEntity> results;

  const SubscriberResultsChart({super.key, required this.results});

  @override
  State<SubscriberResultsChart> createState() => _SubscriberResultsChartState();
}

class _SubscriberResultsChartState extends State<SubscriberResultsChart> {
  bool showAverage = false;

  @override
  Widget build(BuildContext context) {
    if (widget.results.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.noResults,
          style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
      );
    }
    List<TestResultEntity> results = [];
    if (widget.results.length > 6) {
      results = widget.results.sublist(0, 6);
    } else {
      results = widget.results;
    }
    final values = results.map((e) => (e.result ?? 0).toDouble()).toList();
    final maxValue =
        values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) + 5 : 10;
    final avgValue = values.isNotEmpty
        ? values.reduce((a, b) => a + b) / values.length
        : 0.0;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => setState(() => showAverage = !showAverage),
            icon: Icon(showAverage ? Icons.show_chart : Icons.bar_chart,
                color: KMainColor),
            label: Text(showAverage ? LocaleKeys.showMore : LocaleKeys.showLess,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: KMainColor)),
          ),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
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
                minX: 0,
                maxX: values.length - 1,
                minY: 0,
                maxY: showAverage ? avgValue + 5 : maxValue.toDouble(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 5,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: false,
                  )),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: false,
                  )),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 20,
                      getTitlesWidget: (value, meta) => Text(
                        "${LocaleKeys.attempt} ${value.toInt() + 1}",
                        style: AppTextStyles(context)
                            .regular11
                            .copyWith(color: Colors.black87),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: AppTextStyles(context)
                            .regular11
                            .copyWith(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 4,
                    spots: showAverage
                        ? [
                            FlSpot(0, avgValue),
                            FlSpot(values.length - 1, avgValue)
                          ]
                        : List.generate(values.length,
                            (i) => FlSpot(i.toDouble(), values[i])),
                    color: Colors.blueAccent,
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent],
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.3),
                          Colors.greenAccent.withOpacity(0.3)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: const FlDotData(show: true),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map(
                          (spot) => LineTooltipItem(
                            "${LocaleKeys.attempt}: ${spot.x.toInt() + 1}\n ${LocaleKeys.studentScore}: ${spot.y.toStringAsFixed(1)}",
                            const TextStyle(color: Colors.white),
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
