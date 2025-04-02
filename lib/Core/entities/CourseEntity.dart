import 'package:sintir/Core/entities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/SubscriberEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CourseEntity {
  final String id, title, description, language, state;
  final int price;
  final List<Subscriberentity> subscripersIDS;
  String? posterUrl;
  final String postedDate;
  Contentcreaterentity? contentcreaterentity;
  List<CoursSectionsListItemEntity>? coursSectionsListItemEntity;
  final List<CoursefedbackItemEntity> coursefedbackItemEntity;
  final List<Coursereportsitementity> courseReports;
  final int subscripersCount;

  CourseEntity(
      {required this.id,
      required this.state,
      this.posterUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.language,
      required this.subscripersIDS,
      required this.subscripersCount,
      required this.postedDate,
      this.contentcreaterentity,
      this.coursSectionsListItemEntity,
      required this.coursefedbackItemEntity,
      required this.courseReports});
}
