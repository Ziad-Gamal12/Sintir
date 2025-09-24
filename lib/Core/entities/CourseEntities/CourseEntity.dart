// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';

class CourseEntity {
  String id, title, description, language, state;
  int price;
  final int studentsCount;
  String? posterUrl;
  final String postedDate;
  Contentcreaterentity? contentcreaterentity;

  CourseEntity({
    required this.id,
    required this.state,
    this.posterUrl,
    required this.studentsCount,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.postedDate,
    this.contentcreaterentity,
  });
  factory CourseEntity.empty() => CourseEntity(
      id: ' ',
      state: ' ',
      title: ' ',
      description: ' ',
      price: 0,
      language: ' ',
      postedDate: ' ',
      studentsCount: 0);
  static List<CourseEntity> fakeCourses =
      List.generate(10, (index) => CourseEntity.empty());
}
