import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamInfoRow.dart.dart';

class CustomReviewExamDetails extends StatelessWidget {
  const CustomReviewExamDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseTestEntity coursetestentity =
        context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;

    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("تفاصيل الامتحان", style: AppTextStyles(context).bold20),
            const SizedBox(height: 20),
            CustomReviewExamInfoRow(
              icon: Icons.info_outline,
              label: "اسم الامتحان:   ",
              value: coursetestentity.title,
            ),
            const SizedBox(height: 10),
            CustomReviewExamInfoRow(
              icon: Icons.numbers,
              label: "عدد الأسئلة:   ",
              value: "${coursetestentity.questions.length} سؤال",
            ),
            const SizedBox(height: 10),
            CustomReviewExamInfoRow(
              icon: Icons.timer_outlined,
              label: "مدة الامتحان:   ",
              value: "${coursetestentity.durationTime} دقيقة",
            ),
          ],
        ),
      ),
    );
  }
}
