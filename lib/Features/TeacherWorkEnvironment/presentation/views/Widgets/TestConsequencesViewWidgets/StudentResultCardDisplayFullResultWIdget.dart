import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/constant.dart';

class StudentResultCardDisplayFullResultWIdget extends StatelessWidget {
  const StudentResultCardDisplayFullResultWIdget({
    super.key,
    required this.testResultEntity,
  });
  final TestResultEntity testResultEntity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context)
            .push(Reviewtestresultview.routeName, extra: testResultEntity);
      },
      child: Row(
        children: [
          const Icon(Icons.visibility, color: KMainColor),
          const SizedBox(width: 5),
          Text(
            "عرض النتيجة",
            style: AppTextStyles(context).regular16.copyWith(color: KMainColor),
          ),
        ],
      ),
    );
  }
}
