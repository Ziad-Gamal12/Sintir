import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchCoursesLoadingGrid extends StatelessWidget {
  const SearchCoursesLoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: CourseEntity.fakeCourses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GridHelper.getCrossAxisCount(width),
          childAspectRatio: GridHelper.getAspectRatio(maxWidth: width),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => Skeletonizer(
          enabled: true,
          child: CustomCourseItem(
            courseItem: CourseEntity.fakeCourses[index],
            ontap: () {},
          ),
        ),
      ),
    );
  }
}
