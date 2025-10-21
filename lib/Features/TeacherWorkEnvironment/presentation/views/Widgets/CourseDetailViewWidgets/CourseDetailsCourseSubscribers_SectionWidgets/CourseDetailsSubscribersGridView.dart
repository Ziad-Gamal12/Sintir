import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';

class CourseDetailsSubscribersGridView extends StatelessWidget {
  const CourseDetailsSubscribersGridView(
      {super.key, required this.subscribers});
  final List<Subscriberentity> subscribers;
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
      itemBuilder: (context, index) => CourseDetailsSubscribersGridviewItem(
          subscriberentity: subscribers[index]),
    );
  }
}
