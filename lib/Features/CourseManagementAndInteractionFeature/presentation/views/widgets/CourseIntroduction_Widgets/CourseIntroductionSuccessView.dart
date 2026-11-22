import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionStaticWidgets.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessViewSubscribeButtonBuilder.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';
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
        LayoutBuilder(
          builder: (context, constraints) {
            final gutter = ContentWidth.gutter(
              constraints.maxWidth,
              ContentWidth.reading,
              min: KHorizontalPadding,
            );
            final horizontal = EdgeInsets.symmetric(horizontal: gutter);
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding:
                      EdgeInsets.fromLTRB(gutter, KVerticalPadding, gutter, 0),
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
                  SliverPadding(
                    padding: horizontal,
                    sliver:
                        CourseContentListView(courseSectionsEntity: sections),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: isSubscribed ? KVerticalPadding : 100),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: ContentWidth.reading),
              child: CourseIntroductionSuccessViewSubscribeButtonBuilder(
                  isSubscribed: isSubscribed),
            ),
          ),
        ),
      ],
    );
  }
}
