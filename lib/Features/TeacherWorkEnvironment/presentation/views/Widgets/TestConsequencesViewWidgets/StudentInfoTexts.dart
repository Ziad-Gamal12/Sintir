import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({super.key, required this.testResult});
  final TestResultEntity testResult;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final joined = testResult.joinedDate;
    final joinedDate = "${joined.day}/${joined.month}/${joined.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          testResult.joinedbyentity.name,
          style: style.semiBold20,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          "رقم الطالب: ${testResult.joinedbyentity.uid}",
          overflow: TextOverflow.ellipsis,
          style: style.regular14.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          "تاريخ الانضمام: $joinedDate",
          overflow: TextOverflow.ellipsis,
          style: style.regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
