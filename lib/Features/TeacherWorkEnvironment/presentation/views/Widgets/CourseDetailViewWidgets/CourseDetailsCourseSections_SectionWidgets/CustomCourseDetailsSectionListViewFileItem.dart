import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/CustomTrashIcon.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';

class CustomCourseDetailsSectionListViewFileItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewFileItem(
      {super.key,
      required this.item,
      required this.section,
      required this.course});
  final CourseFileEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showInfoSnackBar(context: context, message: "لا يوجد تقرير للملفات");
      },
      child: BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
        selector: (state) {
          return state is DeleteSectionItemLoading &&
              state.sectionItemId == item.id;
        },
        builder: (context, state) {
          return Customcontainersectionitem(
              child: Customlisttilewidget(
                  title: " ${item.title} ",
                  image: item.preffixImage,
                  subtitle: " (${item.description})",
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
                          }))));
        },
      ),
    );
  }
}
