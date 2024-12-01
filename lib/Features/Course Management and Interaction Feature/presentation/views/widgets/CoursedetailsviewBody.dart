import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomCourseDetailsViewBodyHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/courseDeatailsViewBodyDescription.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/courseDetailsViewBodyContentsListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/courseDetailsViewBodyListViewHeader.dart';
import 'package:sintir/constant.dart';

class CoursedetailsviewBody extends StatelessWidget {
  const CoursedetailsviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomCourseDetailsViewBodyHeader(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Coursedeatailsviewbodydescription(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: courseDetailsViewBodyListViewHeader(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          Coursedetailsviewbodyvedioslistview()
        ],
      ),
    );
  }
}
