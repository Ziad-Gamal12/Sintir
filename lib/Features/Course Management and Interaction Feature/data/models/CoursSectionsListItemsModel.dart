import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Courssectionslistitemsmodel {
  final String title, subtitle;
  final List items;

  Courssectionslistitemsmodel(
      {required this.title, required this.subtitle, required this.items});
  factory Courssectionslistitemsmodel.fromEntity(
          {required CoursSectionsListItemEntity coursSectionsListItemEntity}) =>
      Courssectionslistitemsmodel(
          title: coursSectionsListItemEntity.title,
          subtitle: coursSectionsListItemEntity.subtitle,
          items: coursSectionsListItemEntity.items);
  factory Courssectionslistitemsmodel.fromJson(Map<String, dynamic> json) {
    return Courssectionslistitemsmodel(
        title: json['title'],
        subtitle: json['subtitle'],
        items: (json['items'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList());
  }

  CoursSectionsListItemEntity toEntity() => CoursSectionsListItemEntity(
      title: title,
      subtitle: subtitle,
      items: getItemsEntity(items as List<Map<String, dynamic>>));
  Map<String, dynamic> toJson() {
    return {"title": title, "subtitle": subtitle, "items": getItemsJson()};
  }

  List<Map<String, dynamic>> getItemsJson() {
    List<Map<String, dynamic>> courseItems = [];
    for (var item in items) {
      if (item is Coursetestentity) {
        courseItems.add(Coursetestmodel.fromEntity(item).toJson());
      } else if (item is Coursevedioitementity) {
        courseItems.add(Coursevedioitemmodel.fromEntity(item).toJson());
      } else {
        courseItems.add(Coursefilemodel.fromEntity(item).toJson());
      }
    }
    return courseItems;
  }

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
