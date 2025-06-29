import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CustomCourseDetails_OptionItem.dart';

class CourseDetailsViewRowOptions extends StatefulWidget {
  const CourseDetailsViewRowOptions({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<CourseDetailsViewRowOptions> createState() =>
      _CourseDetailsViewRowOptionsState();
}

class _CourseDetailsViewRowOptionsState
    extends State<CourseDetailsViewRowOptions> {
  int currentIndex = 0;
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
                currentIndex = e.key;
                setState(() {});
                widget.pageController.animateToPage(
                  e.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: CustomcoursedetailsOptionitem(
                item: e.value,
                isSelected: e.key == currentIndex,
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }
}
