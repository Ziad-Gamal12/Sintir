import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetUnSubscribedActionButtons.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';

class CustomCourseBottomSheetActionButtons extends StatelessWidget {
  const CustomCourseBottomSheetActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: context
                  .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                  .isSubscribed ==
              false
          ? const CourseBottomSheetUnSubscribedActionButtons()
          : Custombutton(
              text: "الدخول للكورس",
              color: Colors.white,
              textColor: Colors.black,
              side: const BorderSide(width: 1, color: Colors.black),
              onPressed: () {
                GoRouter.of(context).push(CourseIntroductionView.routeName,
                    extra: context.read<
                        DisplayCourseBottomsheetNavigationRequirmentsEntity>());
              }),
    );
  }
}
