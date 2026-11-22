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

  static const double _spacing = 12;
  static const double _fourColumnsMinWidth = 880;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final reasons = widget.reportReasons;
        final columns = constraints.maxWidth >= _fourColumnsMinWidth ? 4 : 2;
        return Column(
          children: [
            for (var start = 0; start < reasons.length; start += columns) ...[
              if (start > 0) const SizedBox(height: _spacing),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var index = start; index < start + columns; index++) ...[
                      if (index > start) const SizedBox(width: _spacing),
                      Expanded(
                        child: index < reasons.length
                            ? _buildItem(index)
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildItem(int index) {
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
  }
}
