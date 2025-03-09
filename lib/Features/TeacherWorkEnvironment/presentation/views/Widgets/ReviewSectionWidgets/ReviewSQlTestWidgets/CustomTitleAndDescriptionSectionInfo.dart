import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

class CustomTitleAndDescriptionSectionInfo extends StatelessWidget {
  const CustomTitleAndDescriptionSectionInfo({
    super.key,
    required this.courseSectionEntity,
  });
  final CoursSectionsListItemEntity courseSectionEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "عنوان المحاضره: ",
            style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: courseSectionEntity.title,
            style: AppTextStyles.regular16.copyWith(color: Colors.grey),
          ),
        ])),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "وصف المحاضره: ",
            style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: courseSectionEntity.subtitle,
            style: AppTextStyles.regular16.copyWith(color: Colors.grey),
          ),
        ]))
      ],
    );
  }
}
