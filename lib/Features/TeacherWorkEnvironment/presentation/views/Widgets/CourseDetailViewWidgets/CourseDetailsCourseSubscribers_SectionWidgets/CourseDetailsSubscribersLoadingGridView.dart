import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscribersLoadingGridView extends StatelessWidget {
  const CourseDetailsSubscribersLoadingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 1.2),
        itemBuilder: (context, index) => CourseDetailsSubscribersGridviewItem(
            subscriberentity: getFakLoadingSubscribers()[index]),
        itemCount: getFakLoadingSubscribers().length,
      ),
    );
  }

  List<Subscriberentity> getFakLoadingSubscribers() {
    return List.generate(6, (index) => Subscriberentity.empty());
  }
}
