import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GridHelper.getCrossAxisCount(width),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: GridHelper.getAspectRatio(maxWidth: width),
      ),
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
