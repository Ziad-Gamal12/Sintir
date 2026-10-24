import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceStatCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsAnalysisCard extends StatelessWidget {
  const SubscriberResultsAnalysisCard({
    super.key,
    required this.summary,
  });

  final SubscriberPerformanceSummary summary;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SubscriberPerformanceStatCard(
              label: LocaleKeys.highestScore,
              result: summary.highest,
              average: false,
              averageValue: summary.average,
              highlight: false,
              valueColor: const Color(0xFF22C55E),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SubscriberPerformanceStatCard(
              label: LocaleKeys.averageResults,
              average: true,
              averageValue: summary.average,
              highlight: true,
              valueColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SubscriberPerformanceStatCard(
              label: LocaleKeys.lowestScore,
              result: summary.lowest,
              average: false,
              averageValue: summary.average,
              highlight: false,
              valueColor: const Color(0xFFFF8C1A),
            ),
          ),
        ],
      ),
    );
  }
}
