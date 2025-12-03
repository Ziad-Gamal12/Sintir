import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionStaticWidgets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessViewSubscribeButtonBuilder.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseIntroductionSuccessView extends StatelessWidget {
  final List<CourseSectionEntity> sections;
  final ScrollController scrollController;
  const CourseIntroductionSuccessView(
      {super.key, required this.sections, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isSubscribed = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .isSubscribed;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverToBoxAdapter(child: CourseIntroductionStaticHeader()),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              const SliverToBoxAdapter(
                  child: courseIntroductionViewBodyListViewHeader()),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              if (sections.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        LocaleKeys.contentComingSoon,
                        style: AppTextStyles(context).semiBold20,
                      ),
                    ),
                  ),
                )
              else
                CourseContentListView(courseSectionsEntity: sections),
              isSubscribed
                  ? const SliverToBoxAdapter(child: SizedBox())
                  : const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CourseIntroductionSuccessViewSubscribeButtonBuilder(
                isSubscribed: isSubscribed))
      ],
    );
  }
}
