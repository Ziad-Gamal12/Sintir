import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// Localized "New" pill (جديد / New / Nouveau) for recently posted courses,
/// in the same primary tonal style as the screen's other accent controls.
class TeacherCourseNewChip extends StatelessWidget {
  const TeacherCourseNewChip({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final tokens = WorkEnvironmentThemeExtension.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.primaryTint,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: tokens.primaryBorder),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: TeacherCourseCardMetrics.chipHorizontalPadding,
          vertical: TeacherCourseCardMetrics.chipVerticalPadding,
        ),
        child: Text(
          LocaleKeys.newCourseLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TeacherCourseCardMetrics.chipStyle(
            context,
          ).copyWith(color: primary),
        ),
      ),
    );
  }
}
