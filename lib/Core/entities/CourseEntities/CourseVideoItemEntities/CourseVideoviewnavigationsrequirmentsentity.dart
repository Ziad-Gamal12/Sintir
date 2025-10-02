import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';

class CourseVideoViewNavigationsRequirmentsEntity {
  final CourseVideoItemEntity video;
  final CourseEntity courseEntity;
  final String sectionId;

  CourseVideoViewNavigationsRequirmentsEntity(
      {required this.video,
      required this.courseEntity,
      required this.sectionId});
}
