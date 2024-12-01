import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class Leatestcoursesglideview extends StatelessWidget {
  const Leatestcoursesglideview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 130 / 170,
        ),
        itemBuilder: (context, index) {
          return CustomCourseItem(
            ontap: () {
              Variables.HomeViewScaffoldKey.currentState!
                  .showBottomSheet((context) {
                return const CourseBottomSheet();
              });
            },
          );
        });
  }
}
