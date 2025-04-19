import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Coursevideoviewnavigationsrequirmentsentity {
  final Coursevedioitementity video;
  final CourseEntity courseEntity;
  final String sectionId;

  Coursevideoviewnavigationsrequirmentsentity(
      {required this.video,
      required this.courseEntity,
      required this.sectionId});
}
