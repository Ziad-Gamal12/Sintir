import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/dashed_border.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/tinted_icon_tile.dart';
import 'package:sintir/locale_keys.dart';

class EmptyVideoPickerCard extends StatelessWidget {
  const EmptyVideoPickerCard({super.key, required this.onPick});

  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);
    final radius = BorderRadius.circular(AddVideoDimens.radius);

    return Semantics(
      button: true,
      label: LocaleKeys.videoPickerTitle,
      child: Material(
        color: colors.surface,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPick,
          child: DashedBorder(
            color: colors.primary.withValues(alpha: .42),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TintedIconTile(
                    icon: Icons.cloud_upload_outlined,
                    size: 64,
                    iconSize: 34,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.videoPickerTitle,
                    textAlign: TextAlign.center,
                    style: styles.bold16,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    LocaleKeys.videoPickerSubtitle,
                    textAlign: TextAlign.center,
                    style: styles.regular12
                        .copyWith(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: onPick,
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                      LocaleKeys.browseVideoFiles,
                      style: styles.semiBold14,
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
