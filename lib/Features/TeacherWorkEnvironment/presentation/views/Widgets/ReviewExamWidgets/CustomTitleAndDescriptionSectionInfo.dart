import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';

class CustomTitleAndDescriptionSectionInfo extends StatelessWidget {
  const CustomTitleAndDescriptionSectionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseSectionEntity courseSectionEntity =
        context.read<NavigateExamReviewRequirmentsEntity>().section;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "عنوان المحاضره: ",
            style:
                AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: courseSectionEntity.title,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.grey),
          ),
        ])),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "وصف المحاضره: ",
            style:
                AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: courseSectionEntity.subtitle,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.grey),
          ),
        ]))
      ],
    );
  }
}
