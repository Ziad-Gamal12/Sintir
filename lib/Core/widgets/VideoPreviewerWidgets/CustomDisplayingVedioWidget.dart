import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/video_player_controller_helper.dart';
import 'package:sintir/locale_keys.dart';

class PremiumVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final File? file;

  final String? title;

  final List<String> availableQualities;

  final int? sourceWidth;
  final int? sourceHeight;

  final bool autoPlay;

  final ValueChanged<Duration>? onDurationChanged;

  const PremiumVideoPlayer({
    super.key,
    this.videoUrl,
    this.file,
    this.title,
    this.availableQualities = const [],
    this.sourceWidth,
    this.sourceHeight,
    this.autoPlay = false,
    this.onDurationChanged,
  });

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
      if (!mounted) return;

      _initializeVideo();
    });
  }

  Future<void> _initializeVideo() async {
    final double? aspectRatio = _calculateAspectRatio();

    await _controller.initializeVideo(
      videoUrl: widget.videoUrl,
      file: widget.file,
      autoPlay: widget.autoPlay,
      aspectRatio: aspectRatio,
      onDurationChanged: widget.onDurationChanged,
    );

    if (mounted && _controller.duration != null) {
      widget.onDurationChanged?.call(_controller.duration!);
    }
  }

  double? _calculateAspectRatio() {
    final width = widget.sourceWidth;
    final height = widget.sourceHeight;

    if (width == null || height == null || width <= 0 || height <= 0) {
      return null;
    }

    return width / height;
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
        return _buildContent(context);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_controller.status) {
      case PremiumVideoPlayerStatus.idle:
      case PremiumVideoPlayerStatus.initializing:
        return _buildLoading(context);

      case PremiumVideoPlayerStatus.failed:
        return _buildError(context);

      case PremiumVideoPlayerStatus.ready:
        return _buildPlayer(context);
    }
  }

  Widget _buildLoading(BuildContext context) {
    return _PlayerFrame(
      aspectRatio: _controller.aspectRatio,
      child: Stack(
        children: [
          const ColoredBox(
            color: Colors.black,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Custom_Loading_Widget(
                isLoading: true,
                child: SizedBox(
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ),
          if (widget.title != null) _buildOverlayTitle(),
        ],
      ),
    );
  }

  Widget _buildPlayer(BuildContext context) {
    final playerController = _controller.betterPlayerController;

    if (playerController == null) {
      return _buildError(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PlayerFrame(
          aspectRatio: _controller.aspectRatio,
          child: BetterPlayer(
            controller: playerController,
          ),
        ),
        if (widget.availableQualities.isNotEmpty) _buildQualityInfo(context),
      ],
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
                  'Unable to load this video.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _controller.retry,
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 18,
                  ),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayTitle() {
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: IgnorePointer(
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildMuxBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildMuxBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.14),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hd_rounded,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            'HLS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityInfo(BuildContext context) {
    final theme = Theme.of(context);

    final sortedQualities = [...widget.availableQualities]..sort(
        (a, b) => _qualityValue(a).compareTo(
          _qualityValue(b),
        ),
      );

    if (sortedQualities.isEmpty) {
      return const SizedBox.shrink();
    }

    final lowest = sortedQualities.first;
    final highest = sortedQualities.last;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(
            Icons.high_quality_rounded,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            'Auto',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$lowest – $highest',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
            ),
          ),
          const Spacer(),
          Text(
            '${widget.availableQualities.length} qualities',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }

  int _qualityValue(String quality) {
    return int.tryParse(
          quality.replaceAll('p', ''),
        ) ??
        0;
  }
}

class _PlayerFrame extends StatelessWidget {
  final double aspectRatio;
  final Widget child;

  const _PlayerFrame({
    required this.aspectRatio,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: ColoredBox(
        color: Colors.black,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: child,
        ),
      ),
    );
  }
}
