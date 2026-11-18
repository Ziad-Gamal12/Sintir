import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class FavoritesviewBodyGridView extends StatelessWidget {
  const FavoritesviewBodyGridView({
    super.key,
    required this.width,
    required this.courses,
  });

  final double width;
  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      gridDelegate: CourseCardGridDelegate.of(context, spacing: 20),
      itemCount: courses.length,
      itemBuilder: (context, index) => CustomCourseItem(
        ontap: () {
          showCustomBottomSheet(
              child: CourseBottomSheet(
                courseEntity: courses[index],
              ),
              context: context);
        },
        courseItem: courses[index],
      ),
    );
  }
}
