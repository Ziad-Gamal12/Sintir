import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class GetCourseFeedBacksResponseEntity {
  final List<CoursefeedbackItemEntity> feedBacks;
  final bool hasMore;
  final bool isPaginate;
  GetCourseFeedBacksResponseEntity(
      {required this.feedBacks,
      required this.hasMore,
      required this.isPaginate});
}
