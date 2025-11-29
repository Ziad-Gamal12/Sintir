import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/CustomTrashIcon.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/VideoConsequencesView.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseDetailsSectionListViewVideoItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewVideoItem({
    super.key,
    required this.item,
    required this.course,
    required this.section,
  });
  final CourseVideoItemEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          VideoConsequencesView.routeName,
          extra: VideoConsequencesViewRequirements(
            courseID: course.id,
            sectionID: section.id,
            video: item,
          ),
        );
      },
      child: BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
        selector: (state) {
          return state is DeleteSectionItemLoading &&
              state.sectionItemId == item.id;
        },
        builder: (context, state) {
          return Customcontainersectionitem(
              child: Customlisttilewidget(
                  subtitle:
                      "${item.durationTime} ${LocaleKeys.durationMinutes}",
                  title: item.title,
                  image: item.preffixImage,
                  trailing: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomTrashIcon(
                      isLoading: state,
                      onpressed: () {
                        context.read<CourseSectionsCubit>().deleteSectionItem(
                              courseId: course.id,
                              sectionId: section.id,
                              sectionItemId: item.id,
                            );
                      },
                    ),
                  )));
        },
      ),
    );
  }
}
