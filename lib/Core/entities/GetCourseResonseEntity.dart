import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

class GetCoursesResonseEntity {
  final List<CourseEntity> courses;
  final bool hasMore;
  GetCoursesResonseEntity({required this.courses, required this.hasMore});
}
