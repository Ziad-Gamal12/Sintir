import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/InfoRow.dart';
import 'package:sintir/constant.dart';

class CourseMetaInfo extends StatelessWidget {
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  const CourseMetaInfo(this.requirmentsEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "تم انشاء بواسطة , ",
              style: AppTextStyles.regular10.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: requirmentsEntity.course.contentcreaterentity?.name,
              style: AppTextStyles.semiBold10.copyWith(color: KSecondaryColor),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        Text(
          "تاريخ النشر (${requirmentsEntity.course.postedDate})",
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
        ),
        const SizedBox(height: 10),
        InfoRow(
          icon: Icons.language,
          label: requirmentsEntity.course.language,
        ),
      ],
    );
  }
}
