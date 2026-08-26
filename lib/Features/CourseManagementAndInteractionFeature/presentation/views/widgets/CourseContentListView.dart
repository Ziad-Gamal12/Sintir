import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomCourseSectionItem/CustomContentListViewitem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseContentListView extends StatelessWidget {
  const CourseContentListView({
    super.key,
    required this.courseSectionsEntity,
  });
  final List<CourseSectionEntity> courseSectionsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
      selector: (state) {
        return state is GetCourseSectionsLoading;
      },
      builder: (context, state) {
        if (state == true) {
          return SliverToBoxAdapter(
              child: ListView.builder(
                  itemCount: getFakeLoadingList().length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomContentListViewitem(
                          course: context
                              .read<
                                  DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                              .course,
                          sectionItem: getFakeLoadingList()[index],
                        ),
                      ),
                    );
                  }));
        }
        return SliverList.builder(
          itemCount: courseSectionsEntity.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomContentListViewitem(
                course: context
                    .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                    .course,
                sectionItem: courseSectionsEntity[index],
              ),
            );
          },
        );
      },
    );
  }

  List<CourseSectionEntity> getFakeLoadingList() {
    List<CourseSectionEntity> list =
        List.generate(6, (index) => CourseSectionEntity.empty());

    return list;
  }
}
