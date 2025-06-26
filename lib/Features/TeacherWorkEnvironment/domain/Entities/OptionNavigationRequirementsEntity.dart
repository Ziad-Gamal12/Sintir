import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';

class Optionnavigationrequirementsentity {
  final CourseSectionEntity section;
  final bool isNewSection;
  final String courseID;

  Optionnavigationrequirementsentity(
      {required this.section,
      required this.courseID,
      required this.isNewSection});
}
