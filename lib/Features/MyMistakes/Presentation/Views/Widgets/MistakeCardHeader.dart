import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MistakeCardHeader extends StatelessWidget {
  final String subject;
  final MistakeStatus status;

  const MistakeCardHeader(
      {super.key, required this.subject, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSubjectBadge(context),
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildSubjectBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: KMainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        subject.isEmpty ? LocaleKeys.subjectGeneral : subject, // Localized
        style: AppTextStyles(context).bold13.copyWith(color: KMainColor),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final Map<MistakeStatus, (Color, String)> statusMap = {
      MistakeStatus.mastered: (Colors.green, LocaleKeys.statusMastered),
      MistakeStatus.improving: (Colors.blue, LocaleKeys.statusImproving),
      MistakeStatus.active: (Colors.orange, LocaleKeys.myMistakesstatusActive),
    };

    final (color, label) = statusMap[status] ?? (Colors.grey, "...");

    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles(context).regular13.copyWith(color: color),
        ),
      ],
    );
  }
}
