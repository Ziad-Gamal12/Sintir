import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';
import 'package:video_player/video_player.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/video_preview_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/video_format.dart';

class VideoThumbnailPreview extends StatelessWidget {
  const VideoThumbnailPreview({super.key, required this.preview});

  final VideoPreviewController preview;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AddVideoDimens.radius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              _PreviewSurface(preview: preview),
              const PositionedDirectional(top: 8, end: 8, child: _ReadyChip()),
              Center(child: _PlayPauseButton(preview: preview)),
              PositionedDirectional(
                bottom: 8,
                start: 8,
                child: _DurationBadge(preview: preview),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewSurface extends StatelessWidget {
  const _PreviewSurface({required this.preview});

  final VideoPreviewController preview;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: preview,
      builder: (context, _) {
        if (!preview.isReady) {
          return Icon(
            Icons.video_library_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          );
        }
        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: preview.size.width,
            height: preview.size.height,
            child: VideoPlayer(preview.player),
          ),
        );
      },
    );
  }
}

class _ReadyChip extends StatelessWidget {
  const _ReadyChip();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          LocaleKeys.videoReadyToUpload,
          style: AppTextStyles(context)
              .semiBold11
              .copyWith(color: colors.onTertiaryContainer),
        ),
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.preview});

  final VideoPreviewController preview;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: preview,
      builder: (context, _) => IconButton.filled(
        tooltip: LocaleKeys.videoPreview,
        onPressed: preview.isReady ? preview.togglePlay : null,
        icon: Icon(preview.isPlaying ? Icons.pause : Icons.play_arrow),
        style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
      ),
    );
  }
}

class _DurationBadge extends StatelessWidget {
  const _DurationBadge({required this.preview});

  final VideoPreviewController preview;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListenableBuilder(
      listenable: preview,
      builder: (context, _) {
        if (!preview.isReady) return const SizedBox.shrink();
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.inverseSurface.withValues(alpha: .8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              formatDuration(preview.duration),
              textDirection: TextDirection.ltr,
              style: AppTextStyles(context)
                  .regular11
                  .copyWith(color: colors.onInverseSurface),
            ),
          ),
        );
      },
    );
  }
}
