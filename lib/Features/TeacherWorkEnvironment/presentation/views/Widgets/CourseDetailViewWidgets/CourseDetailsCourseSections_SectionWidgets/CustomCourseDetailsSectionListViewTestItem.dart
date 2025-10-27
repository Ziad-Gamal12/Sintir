import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomTrashIcon.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ExamConsequencesView.dart';

class CustomCourseDetailsSectionListViewTestItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewTestItem({
    super.key,
    required this.item,
    required this.section,
    required this.course,
  });
  final CourseTestEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
      selector: (state) {
        return state is DeleteSectionItemLoading &&
            state.sectionItemId == item.id;
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            GoRouter.of(context).push(
              TestConsequencesView.routeName,
              extra: TestConsequencesViewRequirements(
                  courseID: course.id, sectionID: section.id, test: item),
            );
          },
          child: Customcontainersectionitem(
              child: Customlisttilewidget(
                  title: " ${item.title} ",
                  image: item.preffixImage,
                  subtitle: " (${item.durationTime} دقائق)",
                  trailing: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomTrashIcon(
                          isLoading: state,
                          onpressed: () {
                            context
                                .read<CourseSectionsCubit>()
                                .deleteSectionItem(
                                  courseId: course.id,
                                  sectionId: section.id,
                                  sectionItemId: item.id,
                                );
                          })))),
        );
      },
    );
  }
}
