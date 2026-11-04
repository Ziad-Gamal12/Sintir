import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/PremiumVideoStrings.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/video_player_controller_helper.dart';
import 'package:sintir/locale_keys.dart';

class PremiumVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final File? file;
  final String? posterUrl;
  final String? title;
  final int? sourceWidth;
  final int? sourceHeight;
  final bool autoPlay;
  final ValueChanged<Duration>? onDurationChanged;

  const PremiumVideoPlayer({
    super.key,
    this.videoUrl,
    this.file,
    this.posterUrl,
    this.title,
    this.sourceWidth,
    this.sourceHeight,
    this.autoPlay = false,
    this.onDurationChanged,
  });

  static String muxUrl(String playbackId) =>
      'https://stream.mux.com/$playbackId.m3u8';
  static String muxPoster(String playbackId) =>
      'https://image.mux.com/$playbackId/thumbnail.jpg?time=1&width=720';

  @override
  State<PremiumVideoPlayer> createState() => _PremiumVideoPlayerState();
}

class _PremiumVideoPlayerState extends State<PremiumVideoPlayer> {
  late final CustomVideoControllerBetter _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomVideoControllerBetter();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _initializeVideo();
    });
  }

  @override
  void didUpdateWidget(covariant PremiumVideoPlayer old) {
    super.didUpdateWidget(old);
    if (old.videoUrl != widget.videoUrl ||
        old.file?.path != widget.file?.path) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    await _controller.initializeVideo(
      videoUrl: widget.videoUrl,
      file: widget.file,
      posterUrl: widget.posterUrl,
      autoPlay: widget.autoPlay,
      aspectRatio: _calculateAspectRatio(),
      onDurationChanged: widget.onDurationChanged,
      controlsBuilder: (player) => PremiumVideoControls(
        player: player,
        controller: _controller,
        title: widget.title,
      ),
    );

    if (mounted && _controller.duration != null) {
      widget.onDurationChanged?.call(_controller.duration!);
    }
  }

  double? _calculateAspectRatio() {
    final w = widget.sourceWidth;
    final h = widget.sourceHeight;
    if (w == null || h == null || w <= 0 || h <= 0) return null;
    return w / h;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final key = switch (_controller.status) {
          PremiumVideoPlayerStatus.ready => 'ready',
          PremiumVideoPlayerStatus.failed => 'failed',
          _ => 'loading',
        };
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(
            key: ValueKey(key),
            child: _buildContent(context),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_controller.status) {
      case PremiumVideoPlayerStatus.idle:
      case PremiumVideoPlayerStatus.initializing:
        return _buildLoading();
      case PremiumVideoPlayerStatus.failed:
        return _buildError(context);
      case PremiumVideoPlayerStatus.ready:
        return _buildPlayer(context);
    }
  }

  Widget _buildLoading() {
    return _PlayerFrame(
      aspectRatio: _controller.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Colors.black),
          if (widget.posterUrl != null)
            Opacity(
              opacity: 0.55,
              child: Image.network(
                widget.posterUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Custom_Loading_Widget(
                isLoading: true,
                child: SizedBox(width: 32, height: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer(BuildContext context) {
    final player = _controller.betterPlayerController;
    if (player == null) return _buildError(context);

    return _PlayerFrame(
      aspectRatio: _controller.aspectRatio,
      child: BetterPlayer(controller: player),
    );
  }

  Widget _buildError(BuildContext context) {
    final theme = Theme.of(context);

    return _PlayerFrame(
      aspectRatio: _controller.aspectRatio,
      child: ColoredBox(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_disabled_rounded,
                    color: theme.colorScheme.error,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  LocaleKeys.videoPlayFailed,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  PremiumVideoStrings.loadFailedHint,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _controller.retry,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(PremiumVideoStrings.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerFrame extends StatelessWidget {
  final double aspectRatio;
  final Widget child;

  const _PlayerFrame({required this.aspectRatio, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: ColoredBox(
        color: Colors.black,
        child: AspectRatio(
          aspectRatio: aspectRatio.clamp(1.0, 2.4),
          child: child,
        ),
      ),
    );
  }
}
