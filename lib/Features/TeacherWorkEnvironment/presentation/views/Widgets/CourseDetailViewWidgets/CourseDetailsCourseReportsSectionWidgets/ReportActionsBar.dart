import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDismissConfirmDialog.dart';
import 'package:sintir/locale_keys.dart';

class ReportActionsBar extends StatefulWidget {
  const ReportActionsBar({
    super.key,
    required this.courseId,
    required this.reportId,
    required this.status,
    this.vertical = false,
  });
  final String courseId, reportId;
  final ReportStatus status;
  final bool vertical;

  @override
  State<ReportActionsBar> createState() => _ReportActionsBarState();
}

class _ReportActionsBarState extends State<ReportActionsBar> {
  static const double _height = 52;
  ReportStatus? _pending; // الزرار اللي اتضغط، عشان الـspinner

  void _update(ReportStatus status) {
    _pending = status;
    context.read<CourseReportsCubit>().updateReportStatus(
      courseId: widget.courseId,
      reportId: widget.reportId,
      newStatus: status,
    );
  }

  Future<void> _dismiss() async {
    final confirmed = await ReportDismissConfirmDialog.confirm(context);
    if (confirmed && mounted) _update(ReportStatus.dismissed);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final neutral = OutlinedButton.styleFrom(
      foregroundColor: scheme.onSurface.withValues(alpha: 0.87),
      side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.24)),
    );

    return BlocBuilder<CourseReportsCubit, CourseReportsState>(
      buildWhen: (_, s) =>
          s is CourseReportsUpdateStatusLoading ||
          s is CourseReportsUpdateStatusSuccess ||
          s is CourseReportsUpdateStatusFailure,
      builder: (context, state) {
        final busy = state is CourseReportsUpdateStatusLoading;
        Widget icon(IconData data, ReportStatus target) =>
            busy && _pending == target ? const _ButtonSpinner() : Icon(data);

        if (widget.status != ReportStatus.open) {
          return SizedBox(
            width: double.infinity,
            height: _height,
            child: OutlinedButton.icon(
              onPressed: busy ? null : () => _update(ReportStatus.open),
              icon: icon(Icons.restart_alt, ReportStatus.open),
              label: Text(LocaleKeys.reportActionReopen),
              style: neutral,
            ),
          );
        }

        final resolved = FilledButton.icon(
          onPressed: busy ? null : () => _update(ReportStatus.resolved),
          icon: icon(Icons.check_circle_outline, ReportStatus.resolved),
          label: Text(
            LocaleKeys.reportMarkResolved,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
        final dismiss = OutlinedButton.icon(
          onPressed: busy ? null : _dismiss,
          icon: icon(Icons.block, ReportStatus.dismissed),
          label: Text(
            LocaleKeys.reportDismissAction,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          style: neutral,
        );

        if (!widget.vertical) {
          return Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [resolved, dismiss],
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 440) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(height: _height, child: resolved),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(height: _height, child: dismiss),
                  ),
                ],
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: _height, child: resolved),
                const SizedBox(height: 10),
                SizedBox(height: _height, child: dismiss),
              ],
            );
          },
        );
      },
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 18,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: IconTheme.of(context).color,
    ),
  );
}
