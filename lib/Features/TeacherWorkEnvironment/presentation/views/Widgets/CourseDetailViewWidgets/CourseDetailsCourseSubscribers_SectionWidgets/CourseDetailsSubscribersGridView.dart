import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
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
  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent + 32;
        if (width < 600) {
          return SliverList.builder(
            itemCount: subscribers.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildCard(context, index, compact: true),
            ),
          );
        }
        final columns = width >= 900
            ? (width / 280).floor().clamp(2, 5).toInt()
            : (width / 280).floor().clamp(1, 2).toInt();
        return SliverGrid.builder(
          itemCount: subscribers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: .88,
          ),
          itemBuilder: (context, index) => _buildCard(context, index),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, int index, {bool compact = false}) {
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
          compact: compact,
        ),
      ),
    );
  }
}
