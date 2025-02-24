import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CustomCourseDetails_OptionIte.dart';

class CourseDetailsViewRowOptions extends StatelessWidget {
  const CourseDetailsViewRowOptions({
    super.key,
    required this.courrentIndex,
    required this.onChanged,
    required this.pageController,
  });

  final int courrentIndex;
  final PageController pageController;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            CoursedetailsviewOptionitemEntity.toList().asMap().entries.map((e) {
          return Expanded(
            child: InkWell(
              onTap: () {
                onChanged(e.key);
                pageController.animateToPage(
                  e.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: CustomcoursedetailsOptionitem(
                item: e.value,
                isSelected: e.key == courrentIndex,
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }
}
