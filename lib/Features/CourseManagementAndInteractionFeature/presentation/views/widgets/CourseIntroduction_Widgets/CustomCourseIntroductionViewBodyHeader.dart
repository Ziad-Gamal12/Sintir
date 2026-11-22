import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CourseInfoCard.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CoursePosterImage.dart';

class CustomCourseIntroductionViewBodyHeader extends StatelessWidget {
  const CustomCourseIntroductionViewBodyHeader({super.key});

  static const double _sideBySideMinWidth = 720;

  @override
  Widget build(BuildContext context) {
    final requirmentsEntity =
        context.read<DisplayCourseBottomsheetNavigationRequirmentsEntity>();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final sideBySide = constraints.maxWidth >= _sideBySideMinWidth;
        final poster = CoursePosterImage(
            imageUrl: requirmentsEntity.course.posterUrl ?? "");
        final info = CourseInfoCard(requirmentsEntity: requirmentsEntity);

        return IntrinsicHeight(
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(sideBySide ? 20 : 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 50,
                    spreadRadius: 1,
                    offset: const Offset(5, 15),
                  )
                ],
              ),
              child: sideBySide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: poster),
                        const SizedBox(width: 24),
                        Expanded(flex: 6, child: info),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        poster,
                        const SizedBox(height: 32),
                        info,
                      ],
                    )),
        );
      },
    );
  }
}
