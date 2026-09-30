import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_type_ui.dart';

class ReportTypeChip extends StatelessWidget {
  const ReportTypeChip({super.key, required this.type});
  final ReportType type;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = type.color(context);
    final alpha = theme.brightness == Brightness.dark ? .20 : .12;
    return Semantics(
        label: type.label,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 230, minHeight: 32),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
              color: color.withValues(alpha: alpha),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(type.icon, color: color, size: 16),
            const SizedBox(width: 5),
            Flexible(
                child: Text(type.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600))),
          ]),
        ));
  }
}
