import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Tinted surface shown when a course has no poster, while it loads, or when
/// it fails to load.
class TeacherCoursePosterPlaceholder extends StatelessWidget {
  const TeacherCoursePosterPlaceholder({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final tokens = WorkEnvironmentThemeExtension.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            tokens.primaryTint,
            // Opaque base so the tint stays subtle with translucent borders.
            tokens.mutedText.withValues(alpha: 0.12),
          ],
        ),
      ),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tokens.cardBackground.withValues(alpha: 0.75),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 22, color: primary.withValues(alpha: 0.75)),
          ),
        ),
      ),
    );
  }
}
