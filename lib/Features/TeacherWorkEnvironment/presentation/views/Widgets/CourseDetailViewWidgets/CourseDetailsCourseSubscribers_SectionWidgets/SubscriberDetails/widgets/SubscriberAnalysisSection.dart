import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberResultsGraph.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberResultsAnalysisCard.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberAnalysisSection extends StatelessWidget {
  const SubscriberAnalysisSection({super.key, required this.results});
  final List<TestResultEntity> results;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.performanceAnalysis,
            style: AppTextStyles(context).semiBold20),
        const SizedBox(height: 20),
        SubscriberResultsChart(results: results),
        const SizedBox(height: 20),
        const SubscriberResultsAnalysisCard(),
      ],
    );
  }
}
