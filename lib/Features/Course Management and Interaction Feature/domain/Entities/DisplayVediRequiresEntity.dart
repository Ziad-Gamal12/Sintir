import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Displayvedirequiresentity {
  final Coursevedioitementity vedioEntity;
  final List<CoursSectionsListItemEntity> sections;

  Displayvedirequiresentity(
      {required this.vedioEntity, required this.sections});
}
