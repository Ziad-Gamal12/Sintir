import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/SubscriberEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsStudentsGridviewItem.dart';

class CoursedetailsStudentsGridview extends StatelessWidget {
  const CoursedetailsStudentsGridview({super.key, required this.subscribers});
  final List<Subscriberentity> subscribers;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subscribers.length,
      itemBuilder: (context, index) => CoursedetailsStudentsGridviewItem(
          subscriberentity: subscribers[index]),
    );
  }
}
