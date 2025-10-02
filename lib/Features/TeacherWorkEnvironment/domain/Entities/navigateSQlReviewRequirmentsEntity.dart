import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class NavigateExamReviewRequirmentsEntity {
  final CourseSectionEntity section;
  final String courseID;
  final CourseTestEntity coursetestentity;
  final bool isNewSection;
  NavigateExamReviewRequirmentsEntity({
    required this.section,
    required this.courseID,
    required this.isNewSection,
    required this.coursetestentity,
  });
}
