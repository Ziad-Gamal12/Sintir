import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_footer_note.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_timeline.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_summary_card.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_timeline_header.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_layout_breakpoints.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_wide_layout.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_end_of_list.dart';

class ResultsAdaptiveLayout extends StatelessWidget {
  const ResultsAdaptiveLayout({
    super.key,
    required this.results,
    required this.average,
    required this.totalCount,
    required this.hasMore,
    required this.isActive,
    required this.scrollController,
    required this.onRefresh,
    required this.isLoadingMore,
  });
  final List<TestResultEntity> results;
  final int average;
  final int totalCount;
  final bool hasMore;
  final bool isActive;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final landscapeTablet =
          MediaQuery.orientationOf(context) == Orientation.landscape &&
          MediaQuery.sizeOf(context).shortestSide >= 600;
      if (constraints.maxWidth >= ResultsLayoutBreakpoints.expanded ||
          landscapeTablet) {
        return ResultsWideLayout(
          results: results,
          average: average,
          totalCount: totalCount,
          hasMore: hasMore,
          isActive: isActive,
          scrollController: scrollController,
          onRefresh: onRefresh,
          isLoadingMore: isLoadingMore,
        );
      }
      final horizontal =
          constraints.maxWidth >= ResultsLayoutBreakpoints.compact
          ? 24.0
          : 16.0;
      return RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth >= ResultsLayoutBreakpoints.compact
                  ? 640
                  : double.infinity,
            ),
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    horizontal,
                    16,
                    horizontal,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ResultsSummaryCard(
                      average: average,
                      count: totalCount,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    horizontal,
                    20,
                    horizontal,
                    8,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: ResultsTimelineHeader(),
                  ),
                ),
                ResultsTimeline(
                  results: results,
                  horizontalPadding: horizontal,
                ),
                if (isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(16),
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                if (!isLoadingMore && !hasMore)
                  const SliverToBoxAdapter(child: ResultsEndOfList()),
                SliverPadding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    horizontal,
                    20,
                    horizontal,
                    24,
                  ),
                  sliver: SliverToBoxAdapter(child: ResultsFooterNote()),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
