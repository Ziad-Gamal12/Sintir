import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/InfoRow.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/ContentCreatorProfile.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseMetaInfo extends StatelessWidget {
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  const CourseMetaInfo(this.requirmentsEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            GoRouter.of(context).push(ContentCreatorProfile.routeName,
                extra: requirmentsEntity.course.contentcreaterentity);
          },
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: LocaleKeys.createdby,
                style: AppTextStyles(context).regular10,
              ),
              TextSpan(
                text: requirmentsEntity.course.contentcreaterentity?.name,
                style: AppTextStyles(context).semiBold10.copyWith(
                    color: KSecondaryColor,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationColor: KSecondaryColor),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${LocaleKeys.createdDate} (${requirmentsEntity.course.postedDate.day}/${requirmentsEntity.course.postedDate.month}/${requirmentsEntity.course.postedDate.year})",
          style: AppTextStyles(context).regular10,
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
