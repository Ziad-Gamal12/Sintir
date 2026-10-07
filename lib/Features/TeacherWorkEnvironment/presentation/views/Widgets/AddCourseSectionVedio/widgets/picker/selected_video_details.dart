import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/video_preview_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/video_format.dart';

class SelectedVideoDetails extends StatelessWidget {
  const SelectedVideoDetails({super.key, required this.preview});

  final VideoPreviewController preview;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final mutedStyle = styles.regular12
        .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return ListenableBuilder(
      listenable: preview,
      builder: (context, _) {
        final sizeBytes = preview.fileSizeBytes;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    preview.fileName,
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.semiBold14,
                  ),
                ),
                const SizedBox(width: 8),
                if (sizeBytes != null)
                  Text(
                    '${formatMegabytes(sizeBytes)} ${LocaleKeys.megabyteUnit}',
                    textDirection: TextDirection.ltr,
                    style: mutedStyle,
                  ),
              ],
            ),
            if (preview.isReady) ...[
              const SizedBox(height: 4),
              Text(
                LocaleKeys.videoMetadata(
                  '${preview.size.width.round()} × ${preview.size.height.round()}',
                  formatDuration(preview.duration),
                ),
                textDirection: TextDirection.ltr,
                style: mutedStyle,
              ),
            ],
          ],
        );
      },
    );
  }
}
