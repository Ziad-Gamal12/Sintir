import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';

class OptionNavigationRequirementsEntity {
  final CourseSectionEntity section;
  final bool isNewSection;
  final CourseEntity courseEntity;

  OptionNavigationRequirementsEntity(
      {required this.section,
      required this.courseEntity,
      required this.isNewSection});
}
