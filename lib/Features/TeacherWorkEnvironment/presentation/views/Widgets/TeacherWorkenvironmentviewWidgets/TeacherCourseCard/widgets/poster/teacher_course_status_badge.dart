import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Pill showing the course review state (published / in review / archived),
/// drawn on an opaque surface so it stays readable over any poster.
class TeacherCourseStatusBadge extends StatelessWidget {
  const TeacherCourseStatusBadge({
    super.key,
    required this.status,
    required this.label,
  });

  final TeacherCourseStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final foreground = status.foregroundColor(tokens);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          status.backgroundColor(tokens),
          tokens.cardBackground.withValues(alpha: 0.94),
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: status.borderColor(tokens)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 3,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: foreground,
              ),
              child: const SizedBox.square(dimension: 6),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).semiBold10.copyWith(color: foreground, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
