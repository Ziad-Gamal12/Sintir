import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class CourseExamViewNavigationsRequirmentsEntity {
  final CourseTestEntity test;
  final String courseId;
  final bool isCourseExam;
  final String sectionId;

  CourseExamViewNavigationsRequirmentsEntity(
      {required this.test,
      required this.courseId,
      required this.isCourseExam,
      required this.sectionId});
}
