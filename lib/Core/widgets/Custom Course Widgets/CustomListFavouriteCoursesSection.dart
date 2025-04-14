// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class Customlistfavouritecoursessection extends StatelessWidget {
  const Customlistfavouritecoursessection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .26,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 137 / 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomCourseItem(
                    ontap: () {}, courseItem: Variables.courseEntity),
              ),
            );
          }),
    );
  }
}
