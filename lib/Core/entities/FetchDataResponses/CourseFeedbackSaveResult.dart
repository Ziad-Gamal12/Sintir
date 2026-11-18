// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

/// What `upsert-course-feedback` returns: the saved review and the course's
/// updated rating summary, so the screen updates without reading again.
class CourseFeedbackSaveResult {
  const CourseFeedbackSaveResult({
    required this.feedback,
    required this.stats,
    required this.created,
  });

  final CoursefeedbackItemEntity feedback;
  final CourseRatingStatsEntity stats;

  /// True for a first review, false for an edit.
  final bool created;
}
