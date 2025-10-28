import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class SearchViewBodyCoursesSliverGridView extends StatelessWidget {
  const SearchViewBodyCoursesSliverGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
        childAspectRatio: GridHelper.getAspectRatio(
            maxWidth: MediaQuery.of(context).size.width),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => CustomCourseItem(
        courseItem: CourseEntity.empty(),
        ontap: () {},
      ),
    );
  }
}
