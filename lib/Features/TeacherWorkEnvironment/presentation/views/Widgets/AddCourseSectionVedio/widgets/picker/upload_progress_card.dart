import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/video_format.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/surface_card.dart';
import 'package:sintir/locale_keys.dart';

class UploadProgressCard extends StatelessWidget {
  const UploadProgressCard({
    super.key,
    required this.progress,
    required this.uploadedBytes,
    required this.totalBytes,
    required this.etaSeconds,
    required this.onCancel,
  });

  final double progress;
  final int uploadedBytes;
  final int totalBytes;
  final int? etaSeconds;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);
    final mutedStyle =
        styles.regular12.copyWith(color: colors.onSurfaceVariant);
    final value = progress.clamp(0.0, 1.0).toDouble();
    final percent = (value * 100).round();

    return Semantics(
      label: LocaleKeys.videoUploadProgress,
      value: '$percent%',
      child: SurfaceCard(
        hasBorder: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_upload_outlined, color: colors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    LocaleKeys.videoUploadingTitle,
                    style: styles.bold14,
                  ),
                ),
                Text(
                  '$percent%',
                  style: styles.bold14.copyWith(color: colors.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(AddVideoDimens.radius),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: colors.primary.withValues(alpha: .13),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    LocaleKeys.videoUploadBytes(
                      formatMegabytes(uploadedBytes),
                      formatMegabytes(totalBytes),
                    ),
                    style: mutedStyle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  etaSeconds == null
                      ? LocaleKeys.calculatingEta
                      : LocaleKeys.videoEta(etaSeconds!),
                  style: mutedStyle,
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: onCancel,
                icon: const Icon(Icons.cancel_outlined),
                label: Text(LocaleKeys.cancelUpload, style: styles.semiBold14),
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  foregroundColor: colors.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
