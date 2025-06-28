// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';

class CourseEntity {
  String id, title, description, language, state;
  int price;
  String? posterUrl;
  final String postedDate;
  Contentcreaterentity? contentcreaterentity;

  CourseEntity({
    required this.id,
    required this.state,
    this.posterUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.postedDate,
    this.contentcreaterentity,
  });
}
