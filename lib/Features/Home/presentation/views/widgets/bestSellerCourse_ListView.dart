import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/bestSellerCourse_item.dart';
import 'package:sintir/constant.dart';

class BestsellercourseListview extends StatelessWidget {
  const BestsellercourseListview({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .26,
      child: ListView.builder(
          padding: const EdgeInsets.only(right: KHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: AspectRatio(
                  aspectRatio: 140 / 202, child: BestsellercourseItem()),
            );
          }),
    );
  }
}
