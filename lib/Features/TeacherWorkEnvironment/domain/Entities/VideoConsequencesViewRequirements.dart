import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';

class VideoConsequencesViewRequirements {
  final String courseID;
  final String sectionID;
  final CourseVideoItemEntity video;
  const VideoConsequencesViewRequirements({
    required this.courseID,
    required this.sectionID,
    required this.video,
  });
}
