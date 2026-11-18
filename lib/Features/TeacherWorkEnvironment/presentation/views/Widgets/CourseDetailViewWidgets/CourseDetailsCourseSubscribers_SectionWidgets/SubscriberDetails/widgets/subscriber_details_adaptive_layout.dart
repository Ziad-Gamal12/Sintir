import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_layout_breakpoints.dart';

class SubscriberDetailsAdaptiveLayout extends StatelessWidget {
  const SubscriberDetailsAdaptiveLayout({
    super.key,
    required this.profile,
    required this.courses,
    required this.analysis,
    required this.timeline,
  });

  final Widget profile;
  final Widget courses;
  final Widget analysis;
  final Widget timeline;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final tabletLandscape =
          MediaQuery.sizeOf(context).shortestSide >=
              SubscriberLayoutBreakpoints.medium &&
          MediaQuery.orientationOf(context) == Orientation.landscape;
      if (constraints.maxWidth >= SubscriberLayoutBreakpoints.expanded ||
          tabletLandscape) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: SubscriberLayoutBreakpoints.expandedContentMaxWidth,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: _Pane(slivers: [_Box(profile, 24), _Box(courses, 0)]),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 6,
                  child: _Pane(slivers: [_Box(analysis, 24), timeline]),
                ),
              ],
            ),
          ),
        );
      }
      final medium = constraints.maxWidth >= SubscriberLayoutBreakpoints.medium;
      return _Pane(
        maxWidth: medium
            ? SubscriberLayoutBreakpoints.mediumContentMaxWidth
            : double.infinity,
        slivers: [
          _Box(profile, medium ? 24 : 16),
          _Box(courses, 0),
          _Box(analysis, medium ? 24 : 16),
          timeline,
        ],
      );
    },
  );
}

class _Box extends StatelessWidget {
  const _Box(this.child, this.padding);
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: EdgeInsetsDirectional.fromSTEB(padding, 0, padding, 24),
    sliver: SliverToBoxAdapter(child: child),
  );
}

class _Pane extends StatelessWidget {
  const _Pane({required this.slivers, this.maxWidth = double.infinity});
  final List<Widget> slivers;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: slivers,
      ),
    ),
  );
}
