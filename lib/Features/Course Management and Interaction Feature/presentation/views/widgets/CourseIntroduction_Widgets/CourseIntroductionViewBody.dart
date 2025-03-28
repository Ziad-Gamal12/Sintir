import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CoursIntroductionviewbodydescription.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CustomCourseIntroductionViewBodyHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';
import 'package:sintir/constant.dart';

class CourseIntroductionViewBody extends StatelessWidget {
  const CourseIntroductionViewBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomCourseIntroductionViewBodyHeader(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: CoursIntroductionviewbodydescription(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: courseIntroductionViewBodyListViewHeader(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          if (context
              .read<Bottomsheetnavigationrequirmentsentity>()
              .course
              .coursSectionsListItemEntity!
              .isEmpty)
            SliverToBoxAdapter(
              child: Center(
                  child: Text(
                "سيتم اضافة المحتوى قريبا ⌛️",
                style: AppTextStyles.bold24.copyWith(color: Colors.black),
              )),
            )
          else
            CourseContentListView(
              courseSectionsEntity: context
                  .read<Bottomsheetnavigationrequirmentsentity>()
                  .course
                  .coursSectionsListItemEntity!,
            )
        ],
      ),
    );
  }
}
