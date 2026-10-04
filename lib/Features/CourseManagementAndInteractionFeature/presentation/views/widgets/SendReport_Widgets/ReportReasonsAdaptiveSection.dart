import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/ReportReasonCardEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonsGridView.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonsListView.dart';

class ReportReasonsAdaptiveSection extends StatefulWidget {
  const ReportReasonsAdaptiveSection({super.key, required this.onSelected});
  final ValueChanged<ReportReasonCardEntity> onSelected;

  @override
  State<ReportReasonsAdaptiveSection> createState() =>
      _ReportReasonsAdaptiveSectionState();
}

class _ReportReasonsAdaptiveSectionState
    extends State<ReportReasonsAdaptiveSection> {
  final List<ReportReasonCardEntity> reportReasons =
      ReportReasonCardEntity.getReportReasonCardEntities();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ReportReasonsListView(
            reportReasons: reportReasons,
            onSelected: widget.onSelected,
          );
        } else {
          return ReportReasonsGridView(
            reportReasons: reportReasons,
            onSelected: widget.onSelected,
          );
        }
      },
    );
  }
}
