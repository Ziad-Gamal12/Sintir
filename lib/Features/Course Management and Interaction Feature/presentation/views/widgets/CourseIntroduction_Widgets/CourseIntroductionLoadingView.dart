import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionStaticWidgets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseIntroductionLoadingView extends StatelessWidget {
  const CourseIntroductionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CourseIntroductionStaticHeader()),
            SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
                child: courseIntroductionViewBodyListViewHeader()),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            CourseContentListView(courseSectionsEntity: []),
          ],
        ),
      ),
    );
  }
}
