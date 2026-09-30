import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsContent.dart';
import 'package:sintir/locale_keys.dart';

class ReportDetailsSheet extends StatelessWidget {
  const ReportDetailsSheet(
      {super.key, required this.courseId, required this.report});
  final String courseId;
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxHeight = MediaQuery.sizeOf(context).height * .9;

    return BlocListener<CourseReportsCubit, CourseReportsState>(
      listenWhen: (_, state) =>
          state is CourseReportsUpdateStatusSuccess ||
          state is CourseReportsUpdateStatusFailure,
      listener: (context, state) {
        if (state is CourseReportsUpdateStatusSuccess) {
          CustomSnackBar.show(context,
              message: LocaleKeys.reportStatusUpdated, type: SnackType.success);
          GoRouter.of(context).pop();
        } else if (state is CourseReportsUpdateStatusFailure) {
          CustomSnackBar.show(context,
              message: LocaleKeys.reportStatusUpdateFailed,
              type: SnackType.error);
        }
      },
      child: Material(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.onSurfaceVariant.withValues(alpha: .32),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                Flexible(
                  child: ReportDetailsContent(
                    courseId: courseId,
                    reportId: report.id,
                    fallbackReport: report,
                    inBottomSheet: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
