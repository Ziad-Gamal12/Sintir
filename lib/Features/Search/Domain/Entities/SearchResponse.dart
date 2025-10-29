import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

class SearchResponse {
  final List<Contentcreaterentity> fetchedTeachersList;
  final List<CourseEntity> fetchedTeachersCoursesList;

  SearchResponse({
    required this.fetchedTeachersList,
    required this.fetchedTeachersCoursesList,
  });
}
