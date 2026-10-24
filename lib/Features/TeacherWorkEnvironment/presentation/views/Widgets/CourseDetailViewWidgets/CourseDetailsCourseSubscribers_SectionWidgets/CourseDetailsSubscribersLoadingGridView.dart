import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscribersLoadingGridView extends StatelessWidget {
  const CourseDetailsSubscribersLoadingGridView({super.key});

  static final List<SubscriberEntity> _placeholders =
      List.generate(6, (_) => SubscriberEntity.empty());

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(builder: (context, constraints) {
      final width = constraints.crossAxisExtent + 32;
      if (width < 600) {
        return SliverList.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Skeletonizer(
                enabled: true,
                child: CourseDetailsSubscribersGridviewItem(
                    subscriber: _placeholders[index], compact: true)),
          ),
        );
      }
      final columns =
          width >= 900 ? (width / 280).floor().clamp(2, 5).toInt() : 2;
      return SliverGrid.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: .88,
        ),
        itemBuilder: (context, index) => Skeletonizer(
            enabled: true,
            child: CourseDetailsSubscribersGridviewItem(
                subscriber: _placeholders[index])),
      );
    });
  }
}
