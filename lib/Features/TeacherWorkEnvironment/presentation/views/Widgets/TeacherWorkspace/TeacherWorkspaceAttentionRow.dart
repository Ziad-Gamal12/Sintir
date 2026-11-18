// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherAttentionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkspaceAttentionRow extends StatelessWidget {
  const TeacherWorkspaceAttentionRow({
    super.key,
    required this.item,
    required this.onTap,
  });

  final TeacherAttentionItem item;
  final VoidCallback onTap;

  static String titleOf(TeacherAttentionItem item, String locale) {
    switch (item.kind) {
      case TeacherAttentionKind.declined:
        return LocaleKeys.attentionDeclined;
      case TeacherAttentionKind.adminHidden:
        return TeacherCourseState.fromRaw(item.course.state) ==
                TeacherCourseState.removedByAdmin
            ? LocaleKeys.attentionRemovedByAdmin
            : LocaleKeys.attentionHiddenByAdmin;
      case TeacherAttentionKind.openReports:
        return LocaleKeys.attentionOpenReports(item.count, locale);
      case TeacherAttentionKind.lowRatings:
        return LocaleKeys.attentionLowRatings(item.count, locale);
      case TeacherAttentionKind.couponEnding:
        return LocaleKeys.attentionCouponEnding(item.coupon?.code ?? '');
    }
  }

  static String subtitleOf(TeacherAttentionItem item, String locale) {
    final parts = <String>[];
    switch (item.kind) {
      case TeacherAttentionKind.declined:
      case TeacherAttentionKind.adminHidden:
      case TeacherAttentionKind.openReports:
        break;
      case TeacherAttentionKind.lowRatings:
        final review = item.review;
        final text = review?.fedBack.trim() ?? '';
        if (text.isNotEmpty) {
          parts.add('«$text»');
        } else if (review?.rating != null) {
          parts.add(LocaleKeys.ratingOutOfFive('${review!.rating}'));
        }
      case TeacherAttentionKind.couponEnding:
        final coupon = item.coupon;
        if (coupon != null && coupon.usageLimit > 0) {
          parts.add(
            LocaleKeys.couponUsageProgress(
              LocaleFormatter.number(coupon.usedCount, locale),
              LocaleFormatter.number(coupon.usageLimit, locale),
            ),
          );
        }
        final daysLeft = item.couponDaysLeft;
        if (daysLeft != null) parts.add(_daysLeftLabel(daysLeft, locale));
    }
    parts.add(item.course.title);
    return parts.join(' · ');
  }

  static String _daysLeftLabel(int daysLeft, String locale) {
    if (daysLeft <= 0) return LocaleKeys.couponEndsToday;
    if (daysLeft == 1) return LocaleKeys.couponEndsTomorrow;
    if (daysLeft == 2) return LocaleKeys.couponEndsInTwoDays;
    return LocaleKeys.couponEndsInDays(
      LocaleFormatter.number(daysLeft, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final title = titleOf(item, locale);
    final subtitle = subtitleOf(item, locale);
    final danger =
        item.kind == TeacherAttentionKind.declined ||
        item.kind == TeacherAttentionKind.adminHidden ||
        item.kind == TeacherAttentionKind.openReports;
    final foreground = danger
        ? tokens.dangerForeground
        : tokens.warningForeground;
    final background = danger
        ? tokens.dangerBackground
        : tokens.warningBackground;

    return Semantics(
      button: true,
      label: '$title، $subtitle',
      child: ExcludeSemantics(
        child: InkWell(
          key: ValueKey('attention-${item.id}'),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_iconOf(item.kind), size: 20, color: foreground),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: styles.semiBold14.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: styles.regular12.copyWith(
                          color: tokens.mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded, color: tokens.mutedText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static IconData _iconOf(TeacherAttentionKind kind) {
    switch (kind) {
      case TeacherAttentionKind.declined:
        return Icons.block_rounded;
      case TeacherAttentionKind.adminHidden:
        return Icons.visibility_off_outlined;
      case TeacherAttentionKind.openReports:
        return Icons.outlined_flag_rounded;
      case TeacherAttentionKind.lowRatings:
        return Icons.star_border_rounded;
      case TeacherAttentionKind.couponEnding:
        return Icons.confirmation_number_outlined;
    }
  }
}
