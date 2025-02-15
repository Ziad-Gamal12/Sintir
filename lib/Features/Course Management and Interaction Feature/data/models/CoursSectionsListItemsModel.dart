import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

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
        title: json['title'], subtitle: json['subtitle'], items: json['items']);
  }

  CoursSectionsListItemEntity toEntity() => CoursSectionsListItemEntity(
      title: title, subtitle: subtitle, items: items);
  Map<String, dynamic> toJson() {
    return {"title": title, "subtitle": subtitle, "items": items};
  }
}
