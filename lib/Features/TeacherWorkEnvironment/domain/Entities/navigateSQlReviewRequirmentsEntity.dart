import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class Navigatesqlreviewrequirmentsentity {
  final CourseSectionEntity section;
  final String courseID;
  final CourseTestEntity coursetestentity;
  final bool isNewSection;
  Navigatesqlreviewrequirmentsentity({
    required this.section,
    required this.courseID,
    required this.isNewSection,
    required this.coursetestentity,
  });
}
