import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class NavigateExamReviewRequirmentsEntity {
  final CourseSectionEntity section;
  final CourseEntity courseEntity;
  final CourseTestEntity coursetestentity;
  final bool isNewSection;
  NavigateExamReviewRequirmentsEntity({
    required this.section,
    required this.courseEntity,
    required this.isNewSection,
    required this.coursetestentity,
  });
}
