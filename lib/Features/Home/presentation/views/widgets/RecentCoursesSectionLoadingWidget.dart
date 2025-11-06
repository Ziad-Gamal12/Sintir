import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentCoursesSectionLoadingWidget extends StatelessWidget {
  const RecentCoursesSectionLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => CustomCourseItem(
          courseItem: CourseEntity.fakeCourses[index],
          ontap: () {},
        ),
        itemCount: CourseEntity.fakeCourses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: GridHelper.getAspectRatio(
              maxWidth: MediaQuery.of(context).size.width),
        ),
      ),
    );
  }
}
