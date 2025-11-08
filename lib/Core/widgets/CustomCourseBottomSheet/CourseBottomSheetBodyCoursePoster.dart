import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseBottomSheetBodyCoursePoster extends StatelessWidget {
  const CourseBottomSheetBodyCoursePoster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? poster = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course
        .posterUrl;
    if (poster == null) {
      return const Placeholder();
    }
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CustomCachedNetworkImage(imageUrl: poster),
        ),
      ),
    );
  }
}
