import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentOptions.dart';

class CustomAddNewSectionItemBottomSheetChild extends StatelessWidget {
  const CustomAddNewSectionItemBottomSheetChild({
    super.key,
    required this.section,
    required this.courseId,
  });

  final CourseSectionEntity section;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.transparent),
      child: AddCourseSectionContentOptions(
        optionRequirementsEntity: OptionNavigationRequirementsEntity(
            isNewSection: false, section: section, courseID: courseId),
      ),
    );
  }
}
