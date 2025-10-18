import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({super.key, required this.testResult});
  final TestResultEntity testResult;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(testResult.joinedbyentity.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles(context).semiBold20),
        const SizedBox(height: 10),
        Text(
          testResult.joinedbyentity.uid,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          "${testResult.joinedDate.day} / ${testResult.joinedDate.month} / ${testResult.joinedDate.year}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
