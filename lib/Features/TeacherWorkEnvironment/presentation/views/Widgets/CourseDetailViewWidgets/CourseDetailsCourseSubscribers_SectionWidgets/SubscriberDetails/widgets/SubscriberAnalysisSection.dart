import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberResultsGraph.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberResultsAnalysisCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_section_header.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_trend_pill.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberAnalysisSection extends StatelessWidget {
  const SubscriberAnalysisSection({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
        buildWhen: (_, state) =>
            state is GetSubscriberResultsLoading ||
            state is GetSubscriberResultsFailure ||
            state is GetSubscriberResultsSuccess,
        builder: (context, state) {
          final summary = state is GetSubscriberResultsSuccess
              ? state.summary
              : SubscriberPerformanceSummary.fromResults(const []);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubscriberSectionHeader(
                title: LocaleKeys.performanceAnalysis,
                trailing: state is GetSubscriberResultsSuccess
                    ? SubscriberTrendPill(summary: state.summary)
                    : null,
              ),
              const SizedBox(height: 12),
              if (state is GetSubscriberResultsFailure)
                Column(
                  children: [
                    CustomErrorWidget(errormessage: state.errmessage),
                    if (onRetry != null)
                      TextButton(
                        onPressed: onRetry,
                        child: Text(LocaleKeys.resultsRetry),
                      ),
                  ],
                )
              else if (state is GetSubscriberResultsLoading ||
                  state is SubuscriberDetailsInitial)
                Skeletonizer(
                  enabled: true,
                  child: Column(
                    children: [
                      SubscriberResultsChart(summary: summary),
                      const SizedBox(height: 12),
                      const SubscriberResultsAnalysisCard(summary: null),
                    ],
                  ),
                )
              else ...[
                SubscriberResultsChart(summary: summary),
                const SizedBox(height: 12),
                SubscriberResultsAnalysisCard(summary: summary),
              ],
            ],
          );
        },
      );
}
