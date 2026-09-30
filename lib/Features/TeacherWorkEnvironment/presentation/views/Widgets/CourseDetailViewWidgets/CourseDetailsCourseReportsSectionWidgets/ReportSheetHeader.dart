import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/locale_keys.dart';

import 'ReportStatusIndicator.dart';
import 'ReportTypeChip.dart';

class ReportSheetHeader extends StatelessWidget {
  const ReportSheetHeader({super.key, required this.report});
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ReportTypeChip(type: report.type),
                ReportStatusIndicator(status: report.status),
              ],
            ),
          ),
          IconButton(
            tooltip: LocaleKeys.cancel,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
