import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/skeleton/teacher_course_skeleton_line.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/skeleton/teacher_course_skeleton_stat.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/teacher_course_card_shell.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Loading placeholder for `TeacherCourseCard`.
///
/// Built from explicit bones on the same shell and metrics as the real card,
/// so it needs no fake course data or network poster. Render it under an
/// enabled `Skeletonizer` (the grid uses one `Skeletonizer.sliver` for all
/// cards so the shimmer sweeps across them in sync).
class TeacherCourseCardSkeleton extends StatelessWidget {
  const TeacherCourseCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: TeacherCourseCardMetrics.maxTextScale,
      child: TeacherCourseCardShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AspectRatio(
              aspectRatio: TeacherCourseCardMetrics.posterAspectRatio,
              child: Bone(),
            ),
            Expanded(
              child: Padding(
                padding: TeacherCourseCardMetrics.bodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TeacherCourseSkeletonLine(
                      style: TeacherCourseCardMetrics.titleStyle(context),
                      widthFactor: 0.85,
                    ),
                    const SizedBox(
                      height: TeacherCourseCardMetrics.titleToMetaGap,
                    ),
                    SizedBox(
                      height: TeacherCourseCardMetrics.metaRowExtent(context),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TeacherCourseSkeletonLine(
                              style: TeacherCourseCardMetrics.priceStyle(
                                context,
                              ),
                              widthFactor: 0.6,
                            ),
                          ),
                          const SizedBox(
                            width: TeacherCourseCardMetrics.inlineGap,
                          ),
                          Expanded(
                            flex: 2,
                            child: TeacherCourseSkeletonStat(
                              style: TeacherCourseCardMetrics.metaStyle(
                                context,
                              ),
                              widthFactor: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Kept as-is so the divider survives the skeleton's
                    // container recolouring in dark mode.
                    Skeleton.keep(
                      child: Divider(
                        height: TeacherCourseCardMetrics.dividerExtent,
                        thickness: 1,
                        color: tokens.cardBorder,
                      ),
                    ),
                    SizedBox(
                      height: TeacherCourseCardMetrics.footerRowExtent(context),
                      child: TeacherCourseSkeletonStat(
                        style: TeacherCourseCardMetrics.footerStyle(context),
                        widthFactor: 0.65,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
