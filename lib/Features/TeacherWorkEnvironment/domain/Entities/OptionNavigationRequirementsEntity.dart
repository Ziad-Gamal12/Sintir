import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';

class OptionNavigationRequirementsEntity {
  final CourseSectionEntity section;
  final bool isNewSection;
  final String courseID;

  OptionNavigationRequirementsEntity(
      {required this.section,
      required this.courseID,
      required this.isNewSection});
}
