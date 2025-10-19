import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class TestConsequencesViewRequirements {
  final String courseID;
  final String sectionID;
  final CourseTestEntity test;
  const TestConsequencesViewRequirements({
    required this.courseID,
    required this.sectionID,
    required this.test,
  });
}
