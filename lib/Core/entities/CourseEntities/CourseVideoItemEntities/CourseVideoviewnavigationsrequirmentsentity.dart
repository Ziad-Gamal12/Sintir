import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';

class Coursevideoviewnavigationsrequirmentsentity {
  final CourseVideoItemEntity video;
  final CourseEntity courseEntity;
  final String sectionId;

  Coursevideoviewnavigationsrequirmentsentity(
      {required this.video,
      required this.courseEntity,
      required this.sectionId});
}
