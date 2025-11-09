import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';

class SubscriberDetailsNavigationRequirements {
  final SubscriberEntity subscriber;
  final String courseId, contentCreatorId;

  SubscriberDetailsNavigationRequirements(
      {required this.subscriber,
      required this.courseId,
      required this.contentCreatorId});
}
