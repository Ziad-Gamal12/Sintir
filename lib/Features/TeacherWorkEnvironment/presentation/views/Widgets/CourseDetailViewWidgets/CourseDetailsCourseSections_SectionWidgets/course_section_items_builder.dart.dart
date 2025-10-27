import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/empty_section_message.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/error_section_message.dart.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/loading_section_items_list.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/section_items_list.dart';

class CourseSectionItemsBuilder extends StatelessWidget {
  const CourseSectionItemsBuilder({
    super.key,
    required this.items,
    required this.course,
    required this.section,
  });

  final List<dynamic> items;
  final CourseEntity course;
  final CourseSectionEntity section;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      buildWhen: (previous, current) =>
          current is GetSectionItemsSuccess ||
          current is GetSectionItemsFailure ||
          current is GetSectionItemsLoading,
      builder: (context, state) {
        if (state is GetSectionItemsLoading && state.sectionId == section.id) {
          return LoadingSectionItemsList(
            fakeItems: List.generate(6, (index) => index),
            course: course,
            section: section,
          );
        } else if (state is GetSectionItemsFailure) {
          return ErrorSectionMessage(message: state.errMessage);
        } else if (state is GetSectionItemsSuccess &&
            state.sectionId == section.id &&
            state.items.isEmpty) {
          return const EmptySectionMessage();
        }
        return SectionItemsList(
          items: items,
          course: course,
          section: section,
        );
      },
    );
  }
}
