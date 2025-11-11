import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetailsContentCreatorCard.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/ContentCreatorProfile.dart';

class CourseItemDetails extends StatelessWidget {
  const CourseItemDetails({
    super.key,
    required this.courseItem,
  });

  final CourseEntity courseItem;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          courseItem.title,
          maxLines: 2,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: styles.semiBold12.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          courseItem.description,
          maxLines: 2,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: styles.regular10.copyWith(color: Colors.grey),
        ),
        const Spacer(),
        if (courseItem.contentcreaterentity != null)
          InkWell(
            onTap: () {
              GoRouter.of(context).push(
                ContentCreatorProfile.routeName,
                extra: courseItem.contentcreaterentity,
              );
            },
            child: CourseItemDetailsContentCreatorCard(
              contentcreaterentity: courseItem.contentcreaterentity!,
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
