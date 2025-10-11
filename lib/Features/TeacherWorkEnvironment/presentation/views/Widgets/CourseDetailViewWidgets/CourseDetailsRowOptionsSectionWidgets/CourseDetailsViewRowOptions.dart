import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CustomCourseDetails_OptionItem.dart';

class CourseDetailsViewRowOptions extends StatelessWidget {
  const CourseDetailsViewRowOptions({
    super.key,
    required this.course,
  });
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    List<CoursedetailsviewOptionitemEntity> items =
        CoursedetailsviewOptionitemEntity.toList(
            context: context, course: course);
    return SliverToBoxAdapter(
        child: GridView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.2 / 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  items[index].onTap();
                },
                child: CustomcoursedetailsOptionitem(
                  item: items[index],
                ),
              );
            }));
  }
}
