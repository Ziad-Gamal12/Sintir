import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

class GetCourseFeedBacksResponseEntity {
  final List<CoursefeedbackItemEntity> feedBacks;
  final bool hasMore;
  final bool isPaginate;
  GetCourseFeedBacksResponseEntity(
      {required this.feedBacks,
      required this.hasMore,
      required this.isPaginate});
}
