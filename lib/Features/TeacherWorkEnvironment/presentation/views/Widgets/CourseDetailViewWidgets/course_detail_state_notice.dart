import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailStateNotice extends StatelessWidget {
  const CourseDetailStateNotice({
    super.key,
    required this.state,
    this.declineReason,
    this.declinedAt,
    this.onResubmit,
    this.resubmitting = false,
  });

  final TeacherCourseState state;
  final String? declineReason;
  final DateTime? declinedAt;
  final VoidCallback? onResubmit;
  final bool resubmitting;

  static bool showsFor(TeacherCourseState state) =>
      state == TeacherCourseState.inReview || state.isBlockedByAdmin;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final styles = AppTextStyles(context);
    final String title;
    final String body;
    final IconData icon;
    var warning = false;
    switch (state) {
      case TeacherCourseState.inReview:
        title = LocaleKeys.courseNoticeInReviewTitle;
        body = LocaleKeys.courseNoticeInReviewBody;
        icon = Icons.hourglass_top_rounded;
        warning = true;
      case TeacherCourseState.declined:
        title = LocaleKeys.attentionDeclined;
        body = LocaleKeys.courseNoticeDeclinedBody;
        icon = Icons.block_rounded;
      case TeacherCourseState.hiddenByAdmin:
        title = LocaleKeys.attentionHiddenByAdmin;
        body = LocaleKeys.courseNoticeHiddenBody;
        icon = Icons.visibility_off_outlined;
      case TeacherCourseState.removedByAdmin:
        title = LocaleKeys.attentionRemovedByAdmin;
        body = LocaleKeys.courseNoticeRemovedBody;
        icon = Icons.delete_outline_rounded;
      case TeacherCourseState.published:
      case TeacherCourseState.archived:
      case TeacherCourseState.unknown:
        return const SizedBox.shrink();
    }
    final foreground = warning
        ? tokens.warningForeground
        : tokens.dangerForeground;

    return Semantics(
      container: true,
      child: Container(
        key: ValueKey('course-state-notice-${state.name}'),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: warning ? tokens.warningBackground : tokens.dangerBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: warning ? tokens.warningBorder : tokens.dangerBorder,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: foreground),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: styles.semiBold14.copyWith(color: foreground),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: styles.regular13.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.5,
                    ),
                  ),
                  if (state == TeacherCourseState.declined) ...[
                    if ((declineReason ?? '').trim().isNotEmpty)
                      _DeclineReason(
                        reason: declineReason!.trim(),
                        declinedAt: declinedAt,
                        color: foreground,
                      ),
                    if (onResubmit != null) ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FilledButton.icon(
                          key: const ValueKey('course-resubmit-button'),
                          style: FilledButton.styleFrom(
                            backgroundColor: foreground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: resubmitting ? null : onResubmit,
                          icon: resubmitting
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send_rounded,
                                  color: Colors.white, size: 18),
                          label: Text(
                            LocaleKeys.courseResubmitButton,
                            style: styles.semiBold13.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeclineReason extends StatelessWidget {
  const _DeclineReason({
    required this.reason,
    required this.declinedAt,
    required this.color,
  });

  final String reason;
  final DateTime? declinedAt;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final theme = Theme.of(context);
    final date = declinedAt;
    return Container(
      key: const ValueKey('course-decline-reason'),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.courseDeclineReasonLabel,
            style: styles.semiBold13.copyWith(color: color),
          ),
          const SizedBox(height: 6),
          SelectableText(
            reason,
            style: styles.regular13.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.6,
            ),
          ),
          if (date != null) ...[
            const SizedBox(height: 6),
            Text(
              LocaleKeys.courseDeclinedOn(
                MaterialLocalizations.of(context).formatMediumDate(date),
              ),
              style: styles.regular12.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
