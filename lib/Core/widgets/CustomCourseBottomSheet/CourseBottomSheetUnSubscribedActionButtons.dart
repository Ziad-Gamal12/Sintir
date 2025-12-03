import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/SubscribtionView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseBottomSheetUnSubscribedActionButtons extends StatelessWidget {
  const CourseBottomSheetUnSubscribedActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      builder: (context, state) {
        return Column(
          children: [
            Custombutton(
              text: LocaleKeys.exploreContent,
              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              textColor: isDark ? Colors.white : Colors.black,
              side: BorderSide(
                  width: 1, color: isDark ? Colors.white70 : Colors.black),
              onPressed: () {
                GoRouter.of(context).push(
                  CourseIntroductionView.routeName,
                  extra: context.read<
                      DisplayCourseBottomsheetNavigationRequirmentsEntity>(),
                );
              },
            ),
            const SizedBox(height: 10),
            Custombutton(
              text: LocaleKeys.subscribeNow,
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {
                GoRouter.of(context).push(
                  SubscribtionView.routeName,
                  extra: context.read<
                      DisplayCourseBottomsheetNavigationRequirmentsEntity>(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
