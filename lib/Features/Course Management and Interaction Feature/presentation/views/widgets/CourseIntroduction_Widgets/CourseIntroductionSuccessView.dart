import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionStaticWidgets.dart';
import 'package:sintir/constant.dart';

class CourseIntroductionSuccessView extends StatelessWidget {
  final List<CourseSectionEntity> sections;

  const CourseIntroductionSuccessView({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: CourseIntroductionStaticHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(
              child: CourseIntroductionStaticDescription()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(
              child: CourseIntroductionStaticListViewHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          if (sections.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "سيتم اضافة المحتوى قريبا ⌛️",
                  style: AppTextStyles.bold24.copyWith(color: Colors.black),
                ),
              ),
            )
          else
            CourseContentListView(courseSectionsEntity: sections),
        ],
      ),
    );
  }
}
