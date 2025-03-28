import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CoursIntroductionviewbodydescription extends StatelessWidget {
  const CoursIntroductionviewbodydescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseEntity course =
        context.read<Bottomsheetnavigationrequirmentsentity>().course;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الوصف",
          style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          course.description,
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
          textAlign: TextAlign.start,
        )
      ],
    );
  }
}
