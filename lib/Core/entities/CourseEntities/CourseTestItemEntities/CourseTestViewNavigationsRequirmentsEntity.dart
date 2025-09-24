import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';

class Coursetestviewnavigationsrequirmentsentity {
  final CourseTestEntity test;
  final CourseEntity course;
  final String sectionId;

  Coursetestviewnavigationsrequirmentsentity(
      {required this.test, required this.course, required this.sectionId});
}
