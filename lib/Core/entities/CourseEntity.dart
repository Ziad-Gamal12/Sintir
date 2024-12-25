import 'package:sintir/Core/entities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/SendCourseReportEntity.dart';

class CourseEntity {
  final String id, posterUrl, title, description, price, language;
  final int subscripers;
  final DateTime postedDate;
  final Contentcreaterentity contentcreaterentity;
  final List<CoursSectionsListItemEntity> coursSectionsListItemEntity;
  final List<CoursefedbackItemEntity> coursefedbackItemEntity;
  final List<Sendcoursereportentity> courseReports;

  CourseEntity(
      {required this.id,
      required this.posterUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.language,
      required this.subscripers,
      required this.postedDate,
      required this.contentcreaterentity,
      required this.coursSectionsListItemEntity,
      required this.coursefedbackItemEntity,
      required this.courseReports});
}
