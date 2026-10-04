import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/ReportReasonCardEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonCardBadge.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonCardSelectedButton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonCardTitleAndDescription.dart';

class ReportReasonListItem extends StatelessWidget {
  const ReportReasonListItem(
      {super.key,
      required this.reportReasonCardEntity,
      required this.isSelected});
  final ReportReasonCardEntity reportReasonCardEntity;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor.withValues(alpha: 0.2)
                : (isDarkMode ? Color(0xff2A2A2A) : Color(0xffFFFFFF)),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Color(0xff000000).withValues(alpha: 0.2)
                    : Color(0xffDEE9FC),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            ReportReasonCardBadge(
              icon: reportReasonCardEntity.icon,
              color: reportReasonCardEntity.color,
            ),
            SizedBox(width: 12),
            Expanded(
              child: ReportReasonCardTitleAndDescription(
                title: reportReasonCardEntity.title,
                description: reportReasonCardEntity.description,
              ),
            ),
            SizedBox(width: 12),
            ReportReasonCardSelectedButton(isSelected: isSelected),
          ],
        ));
  }
}
