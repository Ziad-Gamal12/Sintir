import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionItemButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/course_section_items_builder.dart.dart';

class CourseSectionItemList extends StatelessWidget {
  const CourseSectionItemList({
    super.key,
    required this.section,
    required this.course,
    required this.items,
  });

  final CourseSectionEntity section;
  final CourseEntity course;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      buildWhen: (previous, current) =>
          current is GetSectionItemsSuccess ||
          current is GetSectionItemsFailure ||
          current is GetSectionItemsLoading,
      listener: (context, state) {
        if (state is DeleteSectionItemSuccess) {
          showSuccessSnackBar(
            context: context,
            message: "تم حذف العنصر بنجاح",
          );
        } else if (state is GetSectionItemsFailure) {
          ShowErrorSnackBar(context: context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomAddNewCourseSectionItemButton(
              courseEntity: course,
              section: section,
            ),
            const SizedBox(height: 10),
            CourseSectionItemsBuilder(
              items: items,
              course: course,
              section: section,
            ),
          ],
        );
      },
    );
  }
}
