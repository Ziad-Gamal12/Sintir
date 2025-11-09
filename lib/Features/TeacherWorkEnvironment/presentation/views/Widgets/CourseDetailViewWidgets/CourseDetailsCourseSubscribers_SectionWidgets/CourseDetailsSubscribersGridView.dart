import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/SubscriberDetailsView.dart';

class CourseDetailsSubscribersGridView extends StatelessWidget {
  const CourseDetailsSubscribersGridView(
      {super.key, required this.subscribers, required this.courseEntity});
  final List<SubscriberEntity> subscribers;
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: GridHelper.getAspectRatio(
              maxWidth: MediaQuery.of(context).size.width)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subscribers.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          GoRouter.of(context).push(SubscriberDetailsView.routeName,
              extra: SubscriberDetailsNavigationRequirements(
                  contentCreatorId: courseEntity.contentcreaterentity?.id ?? "",
                  subscriber: subscribers[index],
                  courseId: courseEntity.id));
        },
        child: CourseDetailsSubscribersGridviewItem(
            subscriberentity: subscribers[index]),
      ),
    );
  }
}
