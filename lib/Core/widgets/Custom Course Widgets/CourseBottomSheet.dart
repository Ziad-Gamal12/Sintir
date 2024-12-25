import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetBody.dart';

class CourseBottomSheet extends StatelessWidget {
  const CourseBottomSheet({
    super.key,
    required this.course,
  });
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: Colors.black, width: 1)),
      child: SafeArea(
        child: CourseBottomSheetBody(
          course: course,
        ),
      ),
    );
  }
}
