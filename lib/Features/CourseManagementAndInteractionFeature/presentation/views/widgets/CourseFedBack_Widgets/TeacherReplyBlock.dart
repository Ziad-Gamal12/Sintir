// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/relative_date_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ExpandableReviewText.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReplyBlock extends StatelessWidget {
  const TeacherReplyBlock({super.key, required this.reply});

  final CourseFeedbackReplyEntity reply;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final posted = RelativeDateFormatter.format(
      reply.createdAt,
      now: DateTime.now(),
      locale: locale,
    );
    final meta = reply.isEdited ? '$posted · ${LocaleKeys.reviewEdited}' : posted;
    return Container(
      key: const ValueKey('teacher-reply-block'),
      width: double.infinity,
      margin: const EdgeInsetsDirectional.only(top: 12, start: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KMainColor.withValues(alpha: isDark ? .14 : .06),
        borderRadius: BorderRadius.circular(12),
        border: BorderDirectional(
          start: BorderSide(color: KMainColor.withValues(alpha: .7), width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school_outlined, size: 16, color: KMainColor),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  LocaleKeys.reviewTeacherReplyLabel,
                  style: styles.semiBold13.copyWith(color: KMainColor),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  meta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.regular12.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ExpandableReviewText(
            text: reply.text,
            style: styles.regular14.copyWith(
              color: theme.textTheme.bodyMedium?.color,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
