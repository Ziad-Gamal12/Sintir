import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/ReportReasonCardEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonListItem.dart';

class ReportReasonsListView extends StatefulWidget {
  const ReportReasonsListView(
      {super.key, required this.reportReasons, required this.onSelected});
  final List<ReportReasonCardEntity> reportReasons;
  final ValueChanged<ReportReasonCardEntity> onSelected;
  @override
  State<ReportReasonsListView> createState() => _ReportReasonsListViewState();
}

class _ReportReasonsListViewState extends State<ReportReasonsListView> {
  int currentSelectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.reportReasons.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final reportReason = widget.reportReasons[index];
        return InkWell(
          onTap: () {
            setState(() {
              currentSelectedIndex = index;
            });
            widget.onSelected(reportReason);
          },
          child: ReportReasonListItem(
            reportReasonCardEntity: reportReason,
            isSelected: index == currentSelectedIndex,
          ),
        );
      },
    );
  }
}
