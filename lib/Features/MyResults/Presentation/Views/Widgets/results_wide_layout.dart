import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_footer_note.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_profile_summary.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_timeline.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_timeline_header.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_end_of_list.dart';

class ResultsWideLayout extends StatelessWidget {
  const ResultsWideLayout(
      {super.key,
      required this.results,
      required this.average,
      required this.totalCount,
      required this.hasMore,
      required this.isActive,
      required this.scrollController,
      required this.onRefresh,
      required this.isLoadingMore});
  final List<TestResultEntity> results;
  final int average;
  final int totalCount;
  final bool hasMore;
  final bool isActive;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 38,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 12, 24),
                  child: ResultsProfileSummary(
                      result: results.first,
                      average: average,
                      count: totalCount,
                      isActive: isActive),
                )),
            Expanded(
                flex: 62,
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverPadding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 20, 24, 8),
                        sliver:
                            SliverToBoxAdapter(child: ResultsTimelineHeader())),
                    ResultsTimeline(results: results, horizontalPadding: 12),
                    if (isLoadingMore)
                      const SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsetsDirectional.all(16),
                                  child:
                                      CircularProgressIndicator.adaptive()))),
                    if (!isLoadingMore && !hasMore)
                      const SliverToBoxAdapter(child: ResultsEndOfList()),
                    SliverPadding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 24, 24),
                        sliver: SliverToBoxAdapter(child: ResultsFooterNote())),
                  ],
                )),
          ]),
        )),
      );
}
