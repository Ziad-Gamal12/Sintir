import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/ReportReasonCardEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonGridItem.dart';

class ReportReasonsGridView extends StatefulWidget {
  const ReportReasonsGridView(
      {super.key, required this.reportReasons, required this.onSelected});
  final List<ReportReasonCardEntity> reportReasons;
  final ValueChanged<ReportReasonCardEntity> onSelected;
  @override
  State<ReportReasonsGridView> createState() => _ReportReasonsGridViewState();
}

class _ReportReasonsGridViewState extends State<ReportReasonsGridView> {
  int currentSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: (96 * textScale.clamp(1.0, 1.5)).toDouble(),
      ),
      itemCount: widget.reportReasons.length,
      itemBuilder: (context, index) {
        final reportReason = widget.reportReasons[index];
        return InkWell(
          onTap: () {
            setState(() => currentSelectedIndex = index);
            widget.onSelected(reportReason);
          },
          child: ReportReasonGridItem(
            reportReasonCardEntity: reportReason,
            isSelected: index == currentSelectedIndex,
          ),
        );
      },
    );
  }
}
