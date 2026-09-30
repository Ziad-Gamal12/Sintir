import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/locale_keys.dart';

import 'ReportSheetInfoItem.dart';
import 'utils/report_surface_colors.dart';

class ReportSheetInfoCard extends StatelessWidget {
  const ReportSheetInfoCard({super.key, required this.report});
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat('d MMMM yyyy', locale).format(report.date);
    final time = DateFormat('hh:mm a', locale).format(report.date);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.reportPanelFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.reportPanelBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ReportSheetInfoItem(
              label: LocaleKeys.reportSubmittedBy,
              icon: Icons.person_outline,
              value:
                  '${LocaleKeys.reportStudent} (${LocaleKeys.reportReporterHidden})',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ReportSheetInfoItem(
              label: LocaleKeys.reportSubmittedAt,
              icon: Icons.calendar_today_outlined,
              value: '$date • $time',
            ),
          ),
        ],
      ),
    );
  }
}
