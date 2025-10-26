import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/CourseTestOverViewBodyJoinExamButton.dart';

class OverviewHeaderCard extends StatelessWidget {
  const OverviewHeaderCard({super.key, required this.entity});
  final CourseExamViewNavigationsRequirmentsEntity entity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entity.test.title,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          _OverviewHeaderRow(entity: entity),
          const SizedBox(height: 20),
          CourseTestOverViewBodyJoinExamButton(
              courseExamViewNavigationsRequirmentsEntity: entity),
        ],
      ),
    );
  }
}

class _OverviewHeaderRow extends StatelessWidget {
  const _OverviewHeaderRow({required this.entity});
  final CourseExamViewNavigationsRequirmentsEntity entity;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        AppTextStyles(context).regular14.copyWith(color: Colors.black);
    return Row(
      children: [
        Text("المدة : ${entity.test.durationTime} دقيقة", style: textStyle),
        const Spacer(),
        Text("عدد الأسئلة : ${entity.test.questions.length} سؤال",
            style: textStyle),
      ],
    );
  }
}
