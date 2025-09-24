import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';

class GetCourseSubscribersEntity {
  final List<Subscriberentity> subscribers;
  final bool hasMore;
  final bool isPaginate;

  GetCourseSubscribersEntity(
      {required this.subscribers,
      required this.hasMore,
      required this.isPaginate});
}
