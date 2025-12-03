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
    final theme = Theme.of(context);

    return IntrinsicHeight(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: 1,
                offset: const Offset(5, 15),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CoursePosterImage(
                  imageUrl: requirmentsEntity.course.posterUrl ?? ""),
              const SizedBox(height: 32),
              CourseInfoCard(requirmentsEntity: requirmentsEntity),
            ],
          )),
    );
  }
}
