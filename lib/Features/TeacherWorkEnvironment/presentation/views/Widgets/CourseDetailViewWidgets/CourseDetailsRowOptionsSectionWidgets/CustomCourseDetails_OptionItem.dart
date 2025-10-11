import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CustomcoursedetailsOptionitemDescription.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CustomcoursedetailsOptionitemIcon.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CustomcoursedetailsOptionitemTItleAndArrowIcon.dart';

class CustomcoursedetailsOptionitem extends StatelessWidget {
  const CustomcoursedetailsOptionitem({
    super.key,
    required this.item,
  });
  final CoursedetailsviewOptionitemEntity item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CustomcoursedetailsOptionitemIcon(image: item.image),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                CustomcoursedetailsOptionitemTItleAndArrowIcon(
                    title: item.title),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: CustomcoursedetailsOptionitemDescription(
                      description: item.description),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
