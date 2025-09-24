// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemFavouriteIcon.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';

class CustomCourseItem extends StatelessWidget {
  CustomCourseItem({
    super.key,
    required this.ontap,
    required this.courseItem,
  });

  final VoidCallback ontap;
  final CourseEntity courseItem;
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[30],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 9,
                  child: CourseItemImage(imageUrl: courseItem.posterUrl ?? ""),
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 3,
                  child: CourseItemDetails(courseItem: courseItem),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: CourseItemFavouriteIcon(
                isFavourite: isFavourite,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
