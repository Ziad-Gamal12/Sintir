import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemSchoolLevel extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemSchoolLevel({
    super.key,
    required this.schoolLevel,
  });

  final String schoolLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.school_rounded,
          color: Colors.black,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            schoolLevel == "" ? "غير محدد" : schoolLevel,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
