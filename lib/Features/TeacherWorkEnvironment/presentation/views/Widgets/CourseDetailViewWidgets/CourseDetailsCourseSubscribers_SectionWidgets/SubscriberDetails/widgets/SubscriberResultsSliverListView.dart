import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/results/results_timeline.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_section_header.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberResultsSliverListView extends StatelessWidget {
  const SubscriberResultsSliverListView(
      {super.key, this.courseTitle, this.onRetry});
  final String? courseTitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
        buildWhen: (_, state) =>
            state is GetSubscriberResultsLoading ||
            state is GetSubscriberResultsFailure ||
            state is GetSubscriberResultsSuccess,
        builder: (context, state) {
          final theme = Theme.of(context);
          final sections = <Widget>[
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              sliver: SliverToBoxAdapter(
                child: SubscriberSectionHeader(
                  title: LocaleKeys.resultsTimelineTitle,
                  trailing: courseTitle == null || courseTitle!.isEmpty
                      ? null
                      : Text(courseTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(context).regular12.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                ),
              ),
            ),
          ];
          if (state is GetSubscriberResultsSuccess &&
              state.results.isNotEmpty) {
            sections.add(
                ResultsTimeline(results: state.results, horizontalPadding: 16));
          } else if (state is GetSubscriberResultsLoading ||
              state is SubuscriberDetailsInitial) {
            sections.add(Skeletonizer.sliver(
                enabled: true,
                child: ResultsTimeline(
                    results: List.generate(3, (_) => TestResultEntity.empty()),
                    horizontalPadding: 16)));
          } else if (state is GetSubscriberResultsFailure) {
            sections.add(SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Column(children: [
                CustomErrorWidget(errormessage: state.errmessage),
                if (onRetry != null)
                  TextButton(
                      onPressed: onRetry, child: Text(LocaleKeys.resultsRetry)),
              ]),
            )));
          } else {
            sections.add(SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: CustomEmptyWidget(text: LocaleKeys.noResults),
            )));
          }
          return SliverMainAxisGroup(slivers: sections);
        },
      );
}
