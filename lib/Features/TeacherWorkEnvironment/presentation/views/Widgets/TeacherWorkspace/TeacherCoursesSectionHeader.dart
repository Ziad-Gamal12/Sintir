// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherCoursesSectionHeader extends StatelessWidget {
  const TeacherCoursesSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);

    return Semantics(
      header: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.myCourses,
              style: textStyles.bold20.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: tokens.secondaryButtonFill,
              foregroundColor: theme.colorScheme.primary,
              side: BorderSide(color: tokens.primaryBorder, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(12),
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              minimumSize: const Size(0, 36),
              elevation: 0,
            ),
            onPressed: () {
              GoRouter.of(context).push(Addcourseview.routeName);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  LocaleKeys.addCourse,
                  style: textStyles.semiBold13.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
