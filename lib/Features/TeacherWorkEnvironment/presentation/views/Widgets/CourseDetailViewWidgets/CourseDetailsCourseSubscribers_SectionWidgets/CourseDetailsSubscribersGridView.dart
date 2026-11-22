import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/AdaptiveSliverGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/SubscriberDetailsView.dart';

class CourseDetailsSubscribersGridView extends StatelessWidget {
  const CourseDetailsSubscribersGridView({
    super.key,
    required this.subscribers,
    required this.courseEntity,
  });
  final List<SubscriberEntity> subscribers;
  final CourseEntity courseEntity;

  static const double minCardWidth = 340;
  static const int maxColumns = 3;

  @override
  Widget build(BuildContext context) {
    return AdaptiveSliverGrid(
      itemCount: subscribers.length,
      minItemWidth: minCardWidth,
      maxColumns: maxColumns,
      itemBuilder: _buildCard,
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    final subscriber = subscribers[index];
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => GoRouter.of(context).push(
          SubscriberDetailsView.routeName,
          extra: SubscriberDetailsNavigationRequirements(
            contentCreatorId: courseEntity.contentcreaterentity?.id ?? '',
            subscriber: subscriber,
            courseId: courseEntity.id,
          ),
        ),
        child: CourseDetailsSubscribersGridviewItem(
          subscriber: subscriber,
          compact: true,
        ),
      ),
    );
  }
}
