// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
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

  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(_radius);

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: CourseCardMetrics.maxTextScale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .07),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Material(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: .08)
                  : Colors.black.withValues(alpha: .05),
            ),
          ),
          child: InkWell(
            onTap: ontap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: CourseCardMetrics.imageAspectRatio,
                      child: CourseItemImage(imageUrl: courseItem.posterUrl ?? ''),
                    ),
                    Expanded(
                      child: Padding(
                        padding: CourseCardMetrics.detailsPadding,
                        child: CourseItemDetails(courseItem: courseItem),
                      ),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: 6,
                  end: 6,
                  child: CustomAddFavouriteIcon(courseEntity: courseItem),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
