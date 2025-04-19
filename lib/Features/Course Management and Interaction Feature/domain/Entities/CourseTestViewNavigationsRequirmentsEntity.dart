import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class Coursetestviewnavigationsrequirmentsentity {
  final Coursetestentity test;
  final CourseEntity course;
  final String sectionId;

  Coursetestviewnavigationsrequirmentsentity(
      {required this.test, required this.course, required this.sectionId});
}
