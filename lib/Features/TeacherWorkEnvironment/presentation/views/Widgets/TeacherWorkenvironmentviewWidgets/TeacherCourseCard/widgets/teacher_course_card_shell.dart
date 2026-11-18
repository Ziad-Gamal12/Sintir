import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Rounded, bordered surface shared by the course card and its skeleton.
///
/// The ink layer sits above [child] so the ripple stays visible over the
/// poster image, and the border is a foreground decoration so the image
/// never covers it.
class TeacherCourseCardShell extends StatefulWidget {
  const TeacherCourseCardShell({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<TeacherCourseCardShell> createState() => _TeacherCourseCardShellState();
}

class _TeacherCourseCardShellState extends State<TeacherCourseCardShell> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final borderRadius = BorderRadius.circular(TeacherCourseCardMetrics.radius);

    return AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: tokens.cardBackground,
          borderRadius: borderRadius,
          boxShadow: isDark
              ? const []
              : [
                  BoxShadow(
                    color: tokens.cardShadow,
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: tokens.cardBorder),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            if (widget.onTap != null)
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: widget.onTap,
                    onHighlightChanged: _setPressed,
                    splashColor: primary.withValues(alpha: 0.10),
                    highlightColor: primary.withValues(alpha: 0.05),
                    hoverColor: primary.withValues(alpha: 0.04),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
