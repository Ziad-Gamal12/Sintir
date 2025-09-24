import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseInfoCard.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CoursePosterImage.dart';

class CustomCourseIntroductionViewBodyHeader extends StatelessWidget {
  const CustomCourseIntroductionViewBodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final requirmentsEntity =
        context.read<DisplayCourseBottomsheetNavigationRequirmentsEntity>();
    return IntrinsicHeight(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CoursePosterImage(imageUrl: requirmentsEntity.course.posterUrl ?? ""),
          Positioned(
            left: 20,
            right: 20,
            top: (MediaQuery.of(context).size.width / 2) - 100,
            child: CourseInfoCard(requirmentsEntity: requirmentsEntity),
          ),
        ],
      ),
    );
  }
}
