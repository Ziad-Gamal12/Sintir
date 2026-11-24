import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/PremiumVideoStrings.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/premium_video_controls.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/video_player_controller_helper.dart';
import 'package:sintir/locale_keys.dart';
import 'package:video_player/video_player.dart';

class PremiumVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final File? file;
  final String? posterUrl;
  final String? title;

  final List<String> availableQualities;

  final int? sourceWidth;
  final int? sourceHeight;
  final bool autoPlay;
  final ValueChanged<Duration>? onDurationChanged;
  final Future<String> Function(int? height)? resolveUrl;

  const PremiumVideoPlayer({
    super.key,
    this.videoUrl,
    this.file,
    this.posterUrl,
    this.title,
    this.resolveUrl,
    this.availableQualities = const [],
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
  late final PremiumVideoController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = PremiumVideoController();
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

  List<int> _parseQualities() {
    return widget.availableQualities
        .map((q) => int.tryParse(q.replaceAll('p', '')))
        .whereType<int>()
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
  }

  Future<void> _initializeVideo() async {
    await _controller.initializeVideo(
      videoUrl: widget.videoUrl,
      file: widget.file,
      autoPlay: widget.autoPlay,
      qualities: _parseQualities(),
      urlResolver: widget.resolveUrl,
      aspectRatio: _calculateAspectRatio(),
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

  /// Opens the full-screen route. Leaving it (button or system back) pops
  /// the route, which resumes here and restores the system UI.
  Future<void> _enterFullScreen() async {
    if (_isFullScreen) return;
    setState(() => _isFullScreen = true);

    final navigator = Navigator.of(context, rootNavigator: true);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations(
      _controller.aspectRatio < 1.0
          ? const [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
          : const [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
    );

    // No transition: the video surface is a native view and does not follow
    // Flutter's fade / slide animations.
    await navigator.push(
      PageRouteBuilder<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => _FullScreenVideoPage(
          controller: _controller,
          title: widget.title,
          posterUrl: widget.posterUrl,
        ),
      ),
    );

    if (mounted) setState(() => _isFullScreen = false);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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
        final Key key = switch (_controller.status) {
          // One key per player instance, so a quality switch never puts two
          // children with the same key into the AnimatedSwitcher.
          PremiumVideoPlayerStatus.ready => ObjectKey(_controller.player),
          PremiumVideoPlayerStatus.failed => const ValueKey('failed'),
          _ => const ValueKey('loading'),
        };
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(
            key: key,
            child: _PlayerFrame(
              aspectRatio: _controller.aspectRatio,
              child: _buildContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    final player = _controller.player;
    switch (_controller.status) {
      case PremiumVideoPlayerStatus.idle:
      case PremiumVideoPlayerStatus.initializing:
        return _LoadingView(posterUrl: widget.posterUrl);
      case PremiumVideoPlayerStatus.failed:
        return _ErrorView(onRetry: _controller.retry);
      case PremiumVideoPlayerStatus.ready:
        if (player == null) return _ErrorView(onRetry: _controller.retry);
        return _PlayerStage(
          controller: _controller,
          player: player,
          title: widget.title,
          posterUrl: widget.posterUrl,
          // The full-screen route owns the video surface while it is open.
          showVideo: !_isFullScreen,
          isFullScreen: false,
          onToggleFullScreen: _enterFullScreen,
        );
    }
  }
}

/// Video surface + poster + controls. Used inline and in full screen.
class _PlayerStage extends StatelessWidget {
  final PremiumVideoController controller;
  final VideoPlayerController player;
  final String? title;
  final String? posterUrl;
  final bool showVideo;
  final bool isFullScreen;
  final VoidCallback onToggleFullScreen;

  const _PlayerStage({
    required this.controller,
    required this.player,
    required this.title,
    required this.posterUrl,
    required this.showVideo,
    required this.isFullScreen,
    required this.onToggleFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    final poster = posterUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.black),
        // Sized by layout only (no FittedBox / Transform): a platform view
        // surface is positioned by its layout box, not by paint transforms.
        if (showVideo)
          Center(
            child: AspectRatio(
              aspectRatio: controller.aspectRatio,
              child: VideoPlayer(player),
            ),
          ),
        if (poster != null && !controller.hasStarted)
          Image.network(
            poster,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        PremiumVideoControls(
          player: player,
          controller: controller,
          title: title,
          isFullScreen: isFullScreen,
          onToggleFullScreen: onToggleFullScreen,
        ),
      ],
    );
  }
}

class _FullScreenVideoPage extends StatelessWidget {
  final PremiumVideoController controller;
  final String? title;
  final String? posterUrl;

  const _FullScreenVideoPage({
    required this.controller,
    required this.title,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final player = controller.player;
          if (controller.status == PremiumVideoPlayerStatus.ready &&
              player != null) {
            return _PlayerStage(
              controller: controller,
              player: player,
              title: title,
              posterUrl: posterUrl,
              showVideo: true,
              isFullScreen: true,
              onToggleFullScreen: () => Navigator.of(context).pop(),
            );
          }

          // Loading (e.g. quality switch) or failure: keep a way out.
          return Stack(
            fit: StackFit.expand,
            children: [
              controller.hasError
                  ? _ErrorView(onRetry: controller.retry)
                  : _LoadingView(posterUrl: posterUrl),
              PositionedDirectional(
                top: 8,
                start: 8,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.fullscreen_exit_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String? posterUrl;

  const _LoadingView({required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    final poster = posterUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.black),
        if (poster != null)
          Opacity(
            opacity: 0.55,
            child: Image.network(
              poster,
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
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
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
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text(PremiumVideoStrings.retry),
              ),
            ],
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
