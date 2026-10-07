import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/surface_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/tinted_icon_tile.dart';

class PlatformStandardsCard extends StatelessWidget {
  const PlatformStandardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);

    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      radius: AddVideoDimens.largeRadius,
      hasBorder: false,
      color: colors.surfaceContainerHighest.withValues(alpha: .55),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TintedIconTile(
            icon: Icons.verified_user_outlined,
            color: colors.secondary,
            size: 40,
            isCircle: true,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.videoStandardsTitle, style: styles.bold14),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.videoStandardsBody,
                  style: styles.regular12
                      .copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
