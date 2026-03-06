import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class CourseExamViewNavigationsRequirmentsEntity {
  final CourseTestEntity test;
  final String courseId;
  final String courseSubject;
  final bool isCourseExam;
  final String sectionId;

  CourseExamViewNavigationsRequirmentsEntity(
      {required this.test,
      required this.courseId,
      required this.courseSubject,
      required this.isCourseExam,
      required this.sectionId});
}
