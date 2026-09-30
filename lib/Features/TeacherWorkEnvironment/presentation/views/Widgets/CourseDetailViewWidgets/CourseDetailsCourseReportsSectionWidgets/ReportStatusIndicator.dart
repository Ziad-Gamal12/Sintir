import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_status_ui.dart';

class ReportStatusIndicator extends StatelessWidget {
  const ReportStatusIndicator(
      {super.key, required this.status, this.compact = false});
  final ReportStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = status.color(context);
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(status.icon, size: compact ? 14 : 16, color: color),
        const SizedBox(width: 5),
        Text(
          status.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
    return Semantics(
      label: status.label,
      child: compact
          ? Container(
              constraints: const BoxConstraints(maxWidth: 150),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(
                    alpha: theme.brightness == Brightness.dark ? .16 : .08),
                border: Border.all(color: color.withValues(alpha: .55)),
                borderRadius: BorderRadius.circular(99),
              ),
              child: content,
            )
          : content,
    );
  }
}
