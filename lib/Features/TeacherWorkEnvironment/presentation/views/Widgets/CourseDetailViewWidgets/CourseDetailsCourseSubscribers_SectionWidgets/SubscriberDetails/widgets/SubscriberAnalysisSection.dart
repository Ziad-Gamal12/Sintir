import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberResultsGraph.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberResultsAnalysisCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberAnalysisSection extends StatelessWidget {
  const SubscriberAnalysisSection({
    super.key,
    required this.results,
    required this.summary,
  });
  final List<TestResultEntity> results;
  final SubscriberPerformanceSummary summary;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.performanceAnalysis,
                style: AppTextStyles(context).semiBold20.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_rounded,
                        size: 15, color: theme.colorScheme.primary),
                    const SizedBox(width: 4),
                    Text(
                      LocaleKeys.performanceTrend,
                      style: AppTextStyles(context).regular11.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SubscriberResultsChart(results: results, summary: summary),
        const SizedBox(height: 12),
        SubscriberResultsAnalysisCard(summary: summary),
      ],
    );
  }
}
