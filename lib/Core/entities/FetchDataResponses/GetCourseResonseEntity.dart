import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

class GetCoursesResonseEntity {
  final List<CourseEntity> courses;
  final bool hasMore;
  final bool isPaginate;
  GetCoursesResonseEntity(
      {required this.courses, required this.isPaginate, required this.hasMore});
}
