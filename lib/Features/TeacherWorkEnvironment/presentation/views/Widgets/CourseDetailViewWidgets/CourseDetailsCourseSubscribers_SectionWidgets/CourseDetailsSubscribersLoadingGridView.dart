import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/AdaptiveSliverGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscribersLoadingGridView extends StatelessWidget {
  const CourseDetailsSubscribersLoadingGridView({super.key});

  static final List<SubscriberEntity> _placeholders = List.generate(
    6,
    (_) => SubscriberEntity.empty(),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveSliverGrid(
      itemCount: _placeholders.length,
      minItemWidth: CourseDetailsSubscribersGridView.minCardWidth,
      maxColumns: CourseDetailsSubscribersGridView.maxColumns,
      itemBuilder: (context, index) => Skeletonizer(
        enabled: true,
        child: CourseDetailsSubscribersGridviewItem(
          subscriber: _placeholders[index],
          compact: true,
        ),
      ),
    );
  }
}
