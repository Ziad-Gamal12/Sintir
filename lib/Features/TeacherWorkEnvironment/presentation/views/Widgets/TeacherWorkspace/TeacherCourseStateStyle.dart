// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherCourseStateStyle {
  const TeacherCourseStateStyle._({required this.label, required this.dot});

  final String label;
  final Color dot;

  factory TeacherCourseStateStyle.of(TeacherCourseState state) {
    const tokens = WorkEnvironmentThemeExtension.light;
    switch (state) {
      case TeacherCourseState.published:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusPublished,
          dot: tokens.successForeground,
        );
      case TeacherCourseState.inReview:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusInReview,
          dot: tokens.warningForeground,
        );
      case TeacherCourseState.declined:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusDeclined,
          dot: tokens.dangerForeground,
        );
      case TeacherCourseState.archived:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusArchived,
          dot: tokens.neutralForeground,
        );
      case TeacherCourseState.hiddenByAdmin:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusHiddenByAdmin,
          dot: tokens.dangerForeground,
        );
      case TeacherCourseState.removedByAdmin:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusRemovedByAdmin,
          dot: tokens.dangerForeground,
        );
      case TeacherCourseState.unknown:
        return TeacherCourseStateStyle._(
          label: LocaleKeys.statusUnknown,
          dot: tokens.neutralForeground,
        );
    }
  }
}

class TeacherCourseStatePill extends StatelessWidget {
  const TeacherCourseStatePill({
    super.key,
    required this.state,
    this.textStyle,
  });

  final TeacherCourseState state;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = TeacherCourseStateStyle.of(state);
    return Semantics(
      label: style.label,
      child: ExcludeSemantics(
        child: Container(
          key: ValueKey('course-state-${state.name}'),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: style.dot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  style.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (textStyle ?? const TextStyle(fontSize: 12)).copyWith(
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
