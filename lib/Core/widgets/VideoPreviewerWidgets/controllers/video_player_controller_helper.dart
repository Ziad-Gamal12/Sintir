import 'dart:async';
import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

enum PremiumVideoPlayerStatus { idle, initializing, ready, failed }

typedef PlayerControlsBuilder = Widget Function(BetterPlayerController player);

class CustomVideoControllerBetter extends ChangeNotifier {
  BetterPlayerController? betterPlayerController;

  PremiumVideoPlayerStatus status = PremiumVideoPlayerStatus.idle;
  String? errorMessage;
  Duration? duration;

  /// null = Auto
  int? selectedHeight;
  double speed = 1.0;

  double _aspectRatio = 16 / 9;

  String? _videoUrl;
  File? _file;
  String? _posterUrl;
  bool _autoPlay = false;
  PlayerControlsBuilder? _controlsBuilder;

  /// Quality options (e.g. 720, 540, 480, 360), highest first.
  List<int> _qualities = const [];

  /// Position to resume from after a quality switch.
  Duration? _resumeAt;

  bool _disposed = false;
  int _session = 0;
  Future<String> Function(int? height)? _urlResolver;
  double get aspectRatio => _aspectRatio;
  bool get hasError => status == PremiumVideoPlayerStatus.failed;
  List<int> get qualityHeights => _qualities;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  bool _isStale(int session) => _disposed || session != _session;

  // ───────── initialization ─────────

  /// Starts a new video. Resets quality and speed.
  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    required PlayerControlsBuilder controlsBuilder,
    List<int> qualities = const [],
    Future<String> Function(int? height)? urlResolver,
    String? posterUrl,
    ValueChanged<Duration>? onDurationChanged,
    double? aspectRatio,
    bool autoPlay = false,
  }) async {
    _urlResolver = urlResolver;
    _videoUrl = videoUrl;
    _file = file;
    _posterUrl = posterUrl;
    _autoPlay = autoPlay;
    _controlsBuilder = controlsBuilder;
    _qualities = qualities;

    if (aspectRatio != null && aspectRatio > 0) _aspectRatio = aspectRatio;

    selectedHeight = null;
    speed = 1.0;
    _resumeAt = null;

    await _start(play: autoPlay);
  }

  /// Creates a fresh player. Used for the first load, retry and quality
  /// switches. A new player means a new texture, so the frame size is
  /// always correct (no green bars).
  Future<void> _start({required bool play}) async {
    final session = ++_session;

    _disposeCurrentPlayer();

    status = PremiumVideoPlayerStatus.initializing;
    errorMessage = null;
    duration = null;
    notifyListeners();

    try {
      final controller = BetterPlayerController(_buildConfiguration(play));
      controller.addEventsListener(_handlePlayerEvent);
      betterPlayerController = controller;

      await controller
          .setupDataSource(_buildDataSource())
          .timeout(const Duration(seconds: 25));

      if (_isStale(session)) return;

      if (controller.isVideoInitialized() == true) _handleInitialized();
    } catch (e, stackTrace) {
      if (_isStale(session)) return;
      debugPrint('Video initialization failed: $e');
      debugPrintStack(stackTrace: stackTrace);
      _setFailure();
    }
  }

  BetterPlayerDataSource _buildDataSource() {
    if (_file == null && (_videoUrl == null || _videoUrl!.trim().isEmpty)) {
      throw ArgumentError('A video file or playback URL is required.');
    }

    if (_file != null) {
      return BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        _file!.path,
      );
    }

    final url = _withQuality(_videoUrl!.trim());
    final isHls = _isHlsUrl(url);

    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      videoFormat: isHls ? BetterPlayerVideoFormat.hls : null,
      useAsmsTracks: false, // we no longer switch tracks inside the player
      useAsmsAudioTracks: false,
      useAsmsSubtitles: false,
      liveStream: false,
    );
  }

  /// Mux playback modifiers: min = max = the chosen height leaves only
  /// that rendition in the manifest.
  /// NOTE: with signed playback IDs these must be inside the JWT claims.
  String _withQuality(String url) {
    if (_urlResolver != null) return url;

    final h = selectedHeight;
    if (h == null) return url;

    final uri = Uri.parse(url);
    return uri
        .replace(
          queryParameters: {
            ...uri.queryParameters,
            'min_resolution': '${h}p',
            'max_resolution': '${h}p',
          },
        )
        .toString();
  }

  BetterPlayerConfiguration _buildConfiguration(bool play) {
    final poster = _posterUrl;
    final builder = _controlsBuilder;

    return BetterPlayerConfiguration(
      autoPlay: play,
      looping: false,
      allowedScreenSleep: false,
      fit: BoxFit.contain,
      aspectRatio: _aspectRatio,
      autoDispose: false,
      handleLifecycle: true,
      autoDetectFullscreenDeviceOrientation: true,
      autoDetectFullscreenAspectRatio: true,
      placeholder: poster == null
          ? null
          : Image.network(
              poster,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
      // After a quality switch, show the video frame, not the poster.
      showPlaceholderUntilPlay: poster != null && _resumeAt == null,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        playerTheme: BetterPlayerTheme.custom,
        customControlsBuilder: builder == null
            ? null
            : (player, onVisibilityChanged, config) => builder(player),
      ),
    );
  }

  // ───────── events ─────────

  void _handlePlayerEvent(BetterPlayerEvent event) {
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.initialized:
        _handleInitialized();
        break;
      case BetterPlayerEventType.exception:
        _setFailure();
        break;
      default:
        break;
    }
  }

  void _handleInitialized() {
    final player = betterPlayerController;
    if (player == null) {
      _setFailure();
      return;
    }

    final value = player.videoPlayerController?.value;

    final d = value?.duration;
    if (d != null && d != Duration.zero) duration = d;

    final size = value?.size;
    if (size != null && size.width > 0 && size.height > 0) {
      _aspectRatio = size.width / size.height;
    }

    // Restore state after a quality switch / retry.
    if (speed != 1.0) player.setSpeed(speed);

    final resume = _resumeAt;
    _resumeAt = null;
    if (resume != null && resume > Duration.zero) player.seekTo(resume);

    status = PremiumVideoPlayerStatus.ready;
    errorMessage = null;
    notifyListeners();
  }

  // ───────── actions ─────────

  Future<void> retry() async {
    if (_videoUrl == null && _file == null) return;
    await _start(play: _autoPlay);
  }

  Future<void> play() async => betterPlayerController?.play();
  Future<void> pause() async => betterPlayerController?.pause();
  Future<void> seekTo(Duration p) async => betterPlayerController?.seekTo(p);

  Future<void> setSpeed(double value) async {
    await betterPlayerController?.setSpeed(value);
    speed = value;
    notifyListeners();
  }

  /// [height] null = Auto. Rebuilds the player at the same position.
  Future<void> setQuality(int? height) async {
    final player = betterPlayerController;
    if (player == null || height == selectedHeight) return;

    // Fresh URL first (a signed token may have expired).
    String? freshUrl;
    final resolver = _urlResolver;
    if (resolver != null) {
      try {
        freshUrl = await resolver(height);
      } catch (e) {
        debugPrint('Quality URL resolve failed: $e');
        return;
      }
      if (_disposed || betterPlayerController != player) return;
    }

    final wasPlaying = player.isPlaying() ?? false;
    final position = await player.videoPlayerController?.position;
    if (_disposed || betterPlayerController != player) return;

    if (player.isFullScreen) {
      player.exitFullScreen();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (_disposed || betterPlayerController != player) return;
    }

    if (freshUrl != null) _videoUrl = freshUrl;
    selectedHeight = height;
    _resumeAt = position;
    await _start(play: wasPlaying);
  }

  // ───────── cleanup ─────────

  void _disposeCurrentPlayer() {
    final controller = betterPlayerController;
    if (controller == null) return;

    controller.removeEventsListener(_handlePlayerEvent);
    controller.dispose(forceDispose: true);
    betterPlayerController = null;
  }

  void _setFailure() {
    status = PremiumVideoPlayerStatus.failed;
    errorMessage = 'Unable to load video.';
    notifyListeners();
  }

  bool _isHlsUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.path.toLowerCase().endsWith('.m3u8');
  }

  @override
  void dispose() {
    _disposed = true;
    _session++;
    _disposeCurrentPlayer();
    super.dispose();
  }
}
