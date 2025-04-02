import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';
import 'package:sintir/Core/models/subscripersIDSModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursSectionsListItemsModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursereportsitemModel.dart';

class Coursemodel {
  final String id, posterUrl, title, description, language, state;
  final List<Map<String, dynamic>> subscripersIDS;
  final int price;
  final String postedDate;
  final Map contentcreaterentity;
  final List<Map<String, dynamic>> coursSectionsListItemEntity;
  final List<Map<String, dynamic>> coursefedbackItemEntity;
  final List<Map<String, dynamic>> courseReports;
  final int subscripersCount;

  Coursemodel(
      {required this.id,
      required this.posterUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.language,
      required this.state,
      required this.subscripersIDS,
      required this.subscripersCount,
      required this.postedDate,
      required this.contentcreaterentity,
      required this.coursSectionsListItemEntity,
      required this.coursefedbackItemEntity,
      required this.courseReports});

  factory Coursemodel.fromEntity({required CourseEntity courseEntity}) {
    return Coursemodel(
      subscripersCount: courseEntity.subscripersCount,
      id: courseEntity.id,
      posterUrl: courseEntity.posterUrl ?? "",
      title: courseEntity.title,
      description: courseEntity.description,
      price: courseEntity.price,
      language: courseEntity.language,
      state: courseEntity.state,
      subscripersIDS: courseEntity.subscripersIDS
          .map((e) =>
              Subscripersidsmodel.fromEntit(subscriberentity: e).toJson())
          .toList(),
      postedDate: courseEntity.postedDate,
      contentcreaterentity: courseEntity.contentcreaterentity != null
          ? Contentcreatermodel.fromEntity(
                  entity: courseEntity.contentcreaterentity!)
              .toJson()
          : {},
      coursSectionsListItemEntity:
          courseEntity.coursSectionsListItemEntity != null
              ? courseEntity.coursSectionsListItemEntity!
                  .map((e) => Courssectionslistitemsmodel.fromEntity(
                          coursSectionsListItemEntity: e)
                      .toJson())
                  .toList()
              : [],
      coursefedbackItemEntity: courseEntity.coursefedbackItemEntity
          .map((e) => Coursefedbacksmodel.fromEntity(coursefedbackItemEntity: e)
              .toJson())
          .toList(),
      courseReports: courseEntity.courseReports
          .map((e) =>
              CoursereportsitemModel.fromEntity(courseReportsItemEntity: e)
                  .toJson())
          .toList(),
    );
  }
  factory Coursemodel.fromJson(Map<String, dynamic> json) {
    return Coursemodel(
      id: json['id'],
      posterUrl: json['posterUrl'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      language: json['language'],
      state: json['state'],
      subscripersCount: json['subscripersCount'],
      subscripersIDS: (json['subscripersIDS'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      postedDate: json['postedDate'],
      contentcreaterentity: json['contentcreaterentity'],
      coursSectionsListItemEntity:
          (json['coursSectionsListItemEntity'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
      coursefedbackItemEntity:
          (json['coursefedbackItemEntity'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
      courseReports: (json['courseReports'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }
  CourseEntity toEntity() {
    return CourseEntity(
      subscripersCount: subscripersCount,
      id: id,
      posterUrl: posterUrl,
      title: title,
      description: description,
      price: price,
      language: language,
      state: state,
      subscripersIDS: subscripersIDS
          .map((e) => Subscripersidsmodel.fromJson(e).toEntity())
          .toList(),
      postedDate: postedDate,
      contentcreaterentity:
          Contentcreatermodel.fromJson(data: contentcreaterentity).toEntity(),
      coursSectionsListItemEntity: coursSectionsListItemEntity
          .map((e) => Courssectionslistitemsmodel.fromJson(e).toEntity())
          .toList(),
      coursefedbackItemEntity: coursefedbackItemEntity
          .map((e) => Coursefedbacksmodel.fromJson(e).toEntity())
          .toList(),
      courseReports: courseReports
          .map((e) => CoursereportsitemModel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posterUrl': posterUrl,
      'title': title,
      'description': description,
      'contentcreaterentity': contentcreaterentity,
      'price': price,
      'language': language,
      'state': state,
      'postedDate': postedDate,
      'subscripersIDS': subscripersIDS,
      'coursSectionsListItemEntity': coursSectionsListItemEntity,
      'coursefedbackItemEntity': coursefedbackItemEntity,
      'courseReports': courseReports,
      'subscripersCount': subscripersCount
    };
  }
}
