import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCourseItem.dart';

class Favouritecoursesgrideview extends StatelessWidget {
  const Favouritecoursesgrideview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 157 / 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return const CustomCourseItem();
        });
  }
}
