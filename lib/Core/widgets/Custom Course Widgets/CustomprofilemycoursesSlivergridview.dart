import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class CustomprofilemycoursesSlivergridview extends StatelessWidget {
  const CustomprofilemycoursesSlivergridview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 155 / 198,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 40),
        itemBuilder: (context, index) {
          return CustomCourseItem(
            ontap: () {},
            courseItem: Variables.courseEntity,
          );
        });
  }
}
