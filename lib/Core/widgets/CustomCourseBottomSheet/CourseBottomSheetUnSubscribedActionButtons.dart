import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/CourseIntroductionView.dart';
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
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Custombutton(
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
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Material(
              color: Colors.transparent,
              child: Ink(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.25 : 0.08,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => GoRouter.of(context).push(
                    CourseIntroductionView.routeName,
                    extra: context.read<
                        DisplayCourseBottomsheetNavigationRequirmentsEntity>(),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                  ),
                ),
              ),
            ))
          ],
        );
      },
    );
  }
}
