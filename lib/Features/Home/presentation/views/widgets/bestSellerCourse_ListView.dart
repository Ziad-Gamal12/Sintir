import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';
import 'package:sintir/constant.dart';

class BestsellercourseListview extends StatelessWidget {
  const BestsellercourseListview({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .26,
      child: ListView.builder(
          padding: const EdgeInsets.only(right: KHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AspectRatio(
                aspectRatio: 140 / 202,
                child: CustomCourseItem(
                    courseItem: courses[index],
                    ontap: () {
                      Variables.HomeViewScaffoldKey.currentState!
                          .showBottomSheet((context) {
                        return CourseBottomSheet(
                          courseEntity: courses[index],
                        );
                      });
                    }),
              ),
            );
          }),
    );
  }
}
