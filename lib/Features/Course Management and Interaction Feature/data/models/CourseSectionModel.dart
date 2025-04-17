import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

class CourseSectionModel {
  final String id, title, subtitle;

  CourseSectionModel(
      {required this.title, required this.subtitle, required this.id});
  factory CourseSectionModel.fromEntity(
          {required CourseSectionEntity coursSectionsListItemEntity}) =>
      CourseSectionModel(
          title: coursSectionsListItemEntity.title,
          subtitle: coursSectionsListItemEntity.subtitle,
          id: coursSectionsListItemEntity.id);
  factory CourseSectionModel.fromJson(Map<String, dynamic> json) {
    return CourseSectionModel(
      title: json['title'],
      subtitle: json['subtitle'],
      id: json['id'],
    );
  }

  CourseSectionEntity toEntity() =>
      CourseSectionEntity(title: title, subtitle: subtitle, id: id);
  Map<String, dynamic> toJson() {
    return {"title": title, "subtitle": subtitle, "id": id};
  }

  // List<Map<String, dynamic>> getItemsJson() {
  //   List<Map<String, dynamic>> courseItems = [];
  //   for (var item in items) {
  //     if (item is Coursetestentity) {
  //       courseItems.add(Coursetestmodel.fromEntity(item).toJson());
  //     } else if (item is Coursevedioitementity) {
  //       courseItems.add(Coursevedioitemmodel.fromEntity(item).toJson());
  //     } else {
  //       courseItems.add(Coursefilemodel.fromEntity(item).toJson());
  //     }
  //   }
  //   return courseItems;
  // }

  List getItemsEntity(List<Map<String, dynamic>> items) {
    List courseItems = [];
    for (var item in items) {
      if (item["type"] == "Test") {
        courseItems.add(Coursetestmodel.fromJson(item).toEntity());
      } else if (item["type"] == "Vedio") {
        courseItems.add(Coursevedioitemmodel.fromJson(item).toEntity());
      } else {
        courseItems.add(Coursefilemodel.fromJson(item).toEnity());
      }
    }
    return courseItems;
  }
}
