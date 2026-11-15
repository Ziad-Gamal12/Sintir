import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StudentScoreSpotlightCard extends StatelessWidget {
  const StudentScoreSpotlightCard({
    super.key,
    required this.title,
    required this.badgeIcon,
    required this.accentColor,
    required this.resultEntity,
    this.isLoading = false,
    this.onTap,
  });

  final String title;
  final IconData badgeIcon;
  final Color accentColor;
  final TestResultEntity? resultEntity;
  final bool isLoading;

  final VoidCallback? onTap;

  void _openDetails(BuildContext context) {
    final entity = resultEntity;
    if (entity == null) return;
    showCustomBottomSheet(
      context: context,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: IntrinsicHeight(
            child: StudentResultCard(testResultEntity: entity),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final int score = resultEntity?.result ?? 0;
    final int total = resultEntity?.totalQuestions ?? 0;
    final bool hasData = total > 0;
    final int percent = hasData ? (score / total * 100).round() : 0;

    // Placeholder texts while loading so Skeletonizer draws realistic bones.
    final String rawName = resultEntity?.joinedbyentity.name ?? '';
    final String name = isLoading
        ? 'Student Name Placeholder'
        : (rawName.trim().isEmpty ? '—' : rawName);
    final String imageUrl = isLoading
        ? ''
        : (resultEntity?.joinedbyentity.imageUrl ?? '');

    final String scoreText = hasData ? '$score' : (isLoading ? '00' : '—');
    final String? totalText = hasData ? '$total' : (isLoading ? '00' : null);
    final String? percentText = hasData
        ? '$percent%'
        : (isLoading ? '000%' : null);

    final VoidCallback? effectiveTap = isLoading
        ? null
        : (onTap ?? (hasData ? () => _openDetails(context) : null));

    final Color cardBg = Color.alphaBlend(
      accentColor.withValues(alpha: isDark ? 0.05 : 0.03),
      theme.cardColor,
    );

    return Skeletonizer(
      enabled: isLoading,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: effectiveTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: accentColor.withValues(alpha: isDark ? 0.22 : 0.28),
              ),
            ),
            child: Row(
              children: [
                _SpotlightAvatar(imageUrl: imageUrl, accentColor: accentColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(badgeIcon, size: 14, color: accentColor),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles(
                                context,
                              ).semiBold12.copyWith(color: accentColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(context).semiBold16.copyWith(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _ScoreBlock(
                  scoreText: scoreText,
                  totalText: totalText,
                  percentText: percentText,
                  color: accentColor,
                ),
                if (effectiveTap != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded, // auto-mirrors in RTL
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpotlightAvatar extends StatelessWidget {
  const _SpotlightAvatar({required this.imageUrl, required this.accentColor});

  final String imageUrl;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: accentColor.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CustomCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)
            : Container(
                color: accentColor.withValues(alpha: 0.15),
                alignment: Alignment.center,
                child: Icon(LucideIcons.user, size: 18, color: accentColor),
              ),
      ),
    );
  }
}

class _ScoreBlock extends StatelessWidget {
  const _ScoreBlock({
    required this.scoreText,
    required this.totalText,
    required this.percentText,
    required this.color,
  });

  final String scoreText;
  final String? totalText;
  final String? percentText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Fixed LTR → always reads "0 / 3", never "3 / 0".
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                scoreText,
                style: AppTextStyles(
                  context,
                ).bold24.copyWith(color: color, height: 1.0),
              ),
              if (totalText != null)
                Text(
                  ' / $totalText',
                  style: AppTextStyles(context).semiBold12.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        if (percentText != null) ...[
          const SizedBox(height: 4),
          Text(
            percentText!,
            style: AppTextStyles(
              context,
            ).semiBold12.copyWith(fontSize: 11, color: color),
          ),
        ],
      ],
    );
  }
}

/// Error state with the same footprint as the success row, tap to retry.
class ScoreSpotlightErrorCard extends StatelessWidget {
  const ScoreSpotlightErrorCard({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = theme.colorScheme.error;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onRetry,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: error.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: error.withValues(alpha: 0.3)),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded, size: 22, color: error),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(context).semiBold12.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(
                          context,
                        ).regular12.copyWith(color: error),
                      ),
                    ],
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.refresh_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
