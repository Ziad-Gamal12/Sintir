import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionItemsListEntity.dart';

class CoursSectionsListItemEntity {
  final String title, subtitle;
  final CourseSectionItemsListEntity items;
  CoursSectionsListItemEntity({
    required this.title,
    required this.subtitle,
    required this.items,
  });
}
