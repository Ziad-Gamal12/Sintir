// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseSectionsListViewItem.dart';

class CustomCourseDetailsBodyCourseSections_SliverList extends StatelessWidget {
  const CustomCourseDetailsBodyCourseSections_SliverList({
    super.key,
    required this.courseSections,
    required this.course,
  });

  final List<CourseSectionEntity> courseSections;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listenWhen: (previous, current) =>
          current is DeleteSectionSuccess || current is DeleteSectionFailure,
      buildWhen: (previous, current) =>
          current is DeleteSectionLoading ||
          current is DeleteSectionSuccess ||
          current is DeleteSectionFailure,
      listener: (context, state) {
        if (state is DeleteSectionSuccess) {
          CustomSnackBar.show(
            context,
            message: "تم حذف القسم بنجاح",
            type: SnackType.success,
          );
        } else if (state is DeleteSectionFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      builder: (context, state) => SliverList.builder(
        itemCount: courseSections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Custom_Loading_Widget(
              isLoading: state is DeleteSectionLoading &&
                  state.sectionId == courseSections[index].id,
              child: CustomCourseDetailsSectionsListViewItem(
                course: course,
                sectionItem: courseSections[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
