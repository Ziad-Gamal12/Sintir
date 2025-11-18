import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';

class TestSummaryCard extends StatelessWidget {
  const TestSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseTestEntity courseTestEntity =
        context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseTestEntity.title,
            style:
                AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                context: context,
                icon: Icons.timer_rounded,
                label: "مدة الامتحان",
                value: "${courseTestEntity.durationTime} دقيقة",
              ),
              const SizedBox(width: 25),
              _buildInfoItem(
                context: context,
                icon: Icons.help_outline_rounded,
                label: "عدد الأسئلة",
                value: "${courseTestEntity.questions.length} سؤال",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles(context)
                    .regular14
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles(context)
                    .semiBold16
                    .copyWith(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
