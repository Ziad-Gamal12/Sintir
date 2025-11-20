// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';

class CustomCourseItem extends StatefulWidget {
  final VoidCallback ontap;
  final CourseEntity courseItem;

  const CustomCourseItem({
    super.key,
    required this.ontap,
    required this.courseItem,
  });

  @override
  State<CustomCourseItem> createState() => _CustomCourseItemState();
}

class _CustomCourseItemState extends State<CustomCourseItem> {
  @override
  Widget build(BuildContext context) {
    final course = widget.courseItem;

    return GestureDetector(
      onTap: () {
        widget.ontap();
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CourseItemImage(imageUrl: course.posterUrl ?? ""),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: CourseItemDetails(courseItem: course),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: CustomAddFavouriteIcon(
                courseEntity: course,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
