// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemBadge.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';

class CustomCourseItem extends StatelessWidget {
  final VoidCallback ontap;
  final CourseEntity courseItem;

  const CustomCourseItem({
    super.key,
    required this.ontap,
    required this.courseItem,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(CourseCardMetrics.radius);

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: CourseCardMetrics.maxTextScale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: CourseCardMetrics.shadow(context),
        ),
        child: Material(
          color: CourseCardMetrics.surfaceColor(context),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: CourseCardMetrics.borderColor(context)),
          ),
          child: InkWell(
            onTap: ontap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: CourseCardMetrics.imageAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CourseItemImage(imageUrl: courseItem.posterUrl ?? ''),
                      if (CourseItemBadge.isNew(courseItem))
                        const PositionedDirectional(
                          start: 8,
                          bottom: 8,
                          child: CourseItemBadge(),
                        ),
                      PositionedDirectional(
                        top: 2,
                        end: 2,
                        child: CustomAddFavouriteIcon(courseEntity: courseItem),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: CourseCardMetrics.detailsPadding,
                    child: CourseItemDetails(courseItem: courseItem),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
