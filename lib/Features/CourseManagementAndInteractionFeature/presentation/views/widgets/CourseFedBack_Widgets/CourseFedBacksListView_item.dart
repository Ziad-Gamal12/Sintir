import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/relative_date_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ExpandableReviewText.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/TeacherReplyBlock.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

String reviewMetaText(CoursefeedbackItemEntity item, String locale) {
  final posted = RelativeDateFormatter.format(
    item.datePosted,
    now: DateTime.now(),
    locale: locale,
  );
  return item.isEdited ? '$posted · ${LocaleKeys.reviewEdited}' : posted;
}

class CoursefedbackslistviewItem extends StatelessWidget {
  const CoursefedbackslistviewItem({
    super.key,
    required this.item,
    this.isMine = false,
    this.isNew = false,
    this.trailing,
  });
  final CoursefeedbackItemEntity item;

  final Widget? trailing;

  final bool isMine;

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final rating = item.rating;
    final text = item.fedBack.trim();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ReviewerAvatar(
                name: item.name,
                imageUrl: item.userImage,
                seed: item.uid,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: styles.semiBold14.copyWith(
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        if (isMine) ...[
                          const SizedBox(width: 6),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 110),
                            child: _ReviewTag.own(),
                          ),
                        ],
                        if (isNew) ...[
                          const SizedBox(width: 6),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 80),
                            child: _ReviewTag.fresh(),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (rating != null) ...[
                          StarRatingDisplay(
                            rating: rating.toDouble(),
                            size: 13,
                            semanticLabel: LocaleKeys.ratingOutOfFive(
                              '$rating',
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            reviewMetaText(item, locale),
                            key: ValueKey('review-meta-${item.uid}'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: styles.regular12.copyWith(
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (text.isNotEmpty) ...[
            const SizedBox(height: 10),
            ExpandableReviewText(
              text: text,
              style: styles.regular14.copyWith(
                color: theme.textTheme.bodyMedium?.color,
                height: 1.7,
              ),
            ),
          ],
          if (item.teacherReply != null)
            TeacherReplyBlock(reply: item.teacherReply!),
        ],
      ),
    );
  }
}

class ReviewerAvatar extends StatelessWidget {
  const ReviewerAvatar({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.seed,
    this.size = 40,
  });

  final String name;
  final String imageUrl;
  final String seed;
  final double size;

  static const _darkPalette = [
    _AvatarColors(Color(0xFF2B3F7A), Color(0xFFC9D5FF)),
    _AvatarColors(Color(0xFF1E4D4A), Color(0xFFA8E6DE)),
    _AvatarColors(Color(0xFF5A3E1B), Color(0xFFFFD59A)),
  ];

  static const _lightPalette = [
    _AvatarColors(Color(0xFFDCE4FB), Color(0xFF2F4BA0)),
    _AvatarColors(Color(0xFFD5EFEC), Color(0xFF1D5C55)),
    _AvatarColors(Color(0xFFFBE8C8), Color(0xFF7A5214)),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final palette = isDark ? _darkPalette : _lightPalette;
    final index = seed.codeUnits.fold<int>(0, (sum, unit) => sum + unit);
    final colors = palette[index % palette.length];
    final trimmed = name.trim();
    final initial = trimmed.isEmpty ? '' : trimmed.characters.first;

    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: ClipOval(
          child: imageUrl.isNotEmpty
              ? CustomCachedNetworkImage(imageUrl: imageUrl)
              : ColoredBox(
                  color: colors.background,
                  child: Center(
                    child: initial.isEmpty
                        ? Icon(
                            Icons.person,
                            color: colors.foreground,
                            size: size * 0.55,
                          )
                        : Text(
                            initial.toUpperCase(),
                            style: AppTextStyles(context).bold16.copyWith(
                              color: colors.foreground,
                              height: 1,
                            ),
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _AvatarColors {
  const _AvatarColors(this.background, this.foreground);

  final Color background;
  final Color foreground;
}

class _ReviewTag extends StatelessWidget {
  const _ReviewTag({
    super.key,
    required this.label,
    required this.color,
    required this.darkTextColor,
    required this.lightTextColor,
  });

  _ReviewTag.own()
    : this(
        key: const ValueKey('own-review-chip'),
        label: LocaleKeys.yourReview,
        color: KMainColor,
        darkTextColor: const Color(0xFF9DB4F5),
        lightTextColor: const Color(0xFF2F55C8),
      );

  _ReviewTag.fresh()
    : this(
        key: const ValueKey('new-review-chip'),
        label: LocaleKeys.reviewNewLabel,
        color: KSecondaryColor,
        darkTextColor: const Color(0xFFFFC285),
        lightTextColor: const Color(0xFF9A4A00),
      );

  final String label;
  final Color color;
  final Color darkTextColor;
  final Color lightTextColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.22 : 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles(
          context,
        ).semiBold11.copyWith(color: isDark ? darkTextColor : lightTextColor),
      ),
    );
  }
}
