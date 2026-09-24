import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetUnSubscribedActionButtons.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseBottomSheetActionButtons extends StatelessWidget {
  const CustomCourseBottomSheetActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSubscribed = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .isSubscribed;
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    if (isSubscribed == true) {
      return Custombutton(
          text: LocaleKeys.enterCourse,
          color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
          textColor: isDark ? Colors.white : Colors.black,
          side: BorderSide(width: 1, color: Colors.green),
          onPressed: () {
            GoRouter.of(context).push(CourseIntroductionView.routeName,
                extra: context.read<
                    DisplayCourseBottomsheetNavigationRequirmentsEntity>());
          });
    } else {
      return const CourseBottomSheetUnSubscribedActionButtons();
    }
  }
}
