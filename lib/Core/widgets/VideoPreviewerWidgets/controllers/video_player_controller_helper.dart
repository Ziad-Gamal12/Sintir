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

  bool _disposed = false;
  int _session = 0;

  double get aspectRatio => _aspectRatio;
  bool get hasError => status == PremiumVideoPlayerStatus.failed;

  List<BetterPlayerAsmsTrack> get availableTracks =>
      betterPlayerController?.betterPlayerAsmsTracks ?? [];

  /// Clean quality list (720, 540, 480, 360) from the real HLS tracks.
  List<int> get qualityHeights {
    final heights = <int>{
      for (final t in availableTracks)
        if ((t.height ?? 0) > 0) t.height!,
    };
    return heights.toList()..sort((a, b) => b.compareTo(a));
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  bool _isStale(int session) => _disposed || session != _session;

  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    required PlayerControlsBuilder controlsBuilder,
    String? posterUrl,
    ValueChanged<Duration>? onDurationChanged,
    double? aspectRatio,
    bool autoPlay = false,
  }) async {
    final session = ++_session;

    _videoUrl = videoUrl;
    _file = file;
    _posterUrl = posterUrl;
    _autoPlay = autoPlay;
    _controlsBuilder = controlsBuilder;

    if (aspectRatio != null && aspectRatio > 0) _aspectRatio = aspectRatio;

    _disposeCurrentPlayer();

    status = PremiumVideoPlayerStatus.initializing;
    errorMessage = null;
    duration = null;
    selectedHeight = null;
    speed = 1.0;
    notifyListeners();

    try {
      final controller = BetterPlayerController(_buildConfiguration());
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

    final url = _videoUrl!.trim();
    final isHls = _isHlsUrl(url);

    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      videoFormat: isHls ? BetterPlayerVideoFormat.hls : null,
      useAsmsTracks: isHls,
      useAsmsAudioTracks: false,
      useAsmsSubtitles: false,
      liveStream: false,
    );
  }

  BetterPlayerConfiguration _buildConfiguration() {
    final poster = _posterUrl;
    final builder = _controlsBuilder;

    return BetterPlayerConfiguration(
      autoPlay: _autoPlay,
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
      showPlaceholderUntilPlay: poster != null,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        playerTheme: BetterPlayerTheme.custom,
        customControlsBuilder: builder == null
            ? null
            : (player, onVisibilityChanged, config) => builder(player),
      ),
    );
  }

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

    status = PremiumVideoPlayerStatus.ready;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> retry() async {
    if (_videoUrl == null && _file == null) return;
    final builder = _controlsBuilder;
    if (builder == null) return;

    await initializeVideo(
      videoUrl: _videoUrl,
      file: _file,
      posterUrl: _posterUrl,
      autoPlay: _autoPlay,
      aspectRatio: _aspectRatio,
      controlsBuilder: builder,
    );
  }

  Future<void> play() async => betterPlayerController?.play();
  Future<void> pause() async => betterPlayerController?.pause();
  Future<void> seekTo(Duration p) async => betterPlayerController?.seekTo(p);

  Future<void> setSpeed(double value) async {
    await betterPlayerController?.setSpeed(value);
    speed = value;
    notifyListeners();
  }

  /// [height] null = Auto (adaptive).
  void setQuality(int? height) {
    final player = betterPlayerController;
    if (player == null) return;

    if (height == null) {
      player.setTrack(BetterPlayerAsmsTrack.defaultTrack());
    } else {
      final matches = availableTracks.where((t) => t.height == height).toList()
        ..sort((a, b) => (a.bitrate ?? 0).compareTo(b.bitrate ?? 0));
      if (matches.isEmpty) return;
      player.setTrack(matches.last);
    }

    selectedHeight = height;
    notifyListeners();
  }

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
