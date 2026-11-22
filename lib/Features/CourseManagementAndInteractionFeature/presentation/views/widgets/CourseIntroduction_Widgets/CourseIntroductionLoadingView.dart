import 'package:flutter/material.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionStaticWidgets.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseIntroductionLoadingView extends StatelessWidget {
  const CourseIntroductionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = EdgeInsets.symmetric(
            horizontal: ContentWidth.gutter(
              constraints.maxWidth,
              ContentWidth.reading,
              min: KHorizontalPadding,
            ),
          );
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: horizontal,
                sliver: const SliverToBoxAdapter(
                    child: CourseIntroductionStaticHeader()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              SliverPadding(
                padding: horizontal,
                sliver: const SliverToBoxAdapter(
                    child: courseIntroductionViewBodyListViewHeader()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverPadding(
                padding: horizontal,
                sliver: const CourseContentListView(courseSectionsEntity: []),
              ),
            ],
          );
        },
      ),
    );
  }
}
