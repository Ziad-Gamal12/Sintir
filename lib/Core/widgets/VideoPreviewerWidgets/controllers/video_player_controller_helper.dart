import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

enum PremiumVideoPlayerStatus {
  idle,
  initializing,
  ready,
  failed,
}

class CustomVideoControllerBetter extends ChangeNotifier {
  BetterPlayerController? betterPlayerController;

  PremiumVideoPlayerStatus status = PremiumVideoPlayerStatus.idle;

  String? errorMessage;
  Duration? duration;

  double _aspectRatio = 16 / 9;

  String? _videoUrl;
  File? _file;
  bool _autoPlay = false;

  bool get isInitialized =>
      betterPlayerController?.isVideoInitialized() ?? false;

  bool get isBuffering =>
      betterPlayerController?.isBuffering() ?? false;

  bool get isPlaying =>
      betterPlayerController?.isPlaying() ?? false;

  bool get hasError => status == PremiumVideoPlayerStatus.failed;

  double get aspectRatio => _aspectRatio;

  List<BetterPlayerAsmsTrack> get availableTracks {
    return betterPlayerController?.betterPlayerAsmsTracks ?? [];
  }

  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    ValueChanged<Duration>? onDurationChanged,
    double? aspectRatio,
    bool autoPlay = false,
  }) async {
    _videoUrl = videoUrl;
    _file = file;
    _autoPlay = autoPlay;

    if (aspectRatio != null && aspectRatio > 0) {
      _aspectRatio = aspectRatio;
    }

    await _disposeCurrentPlayer();

    status = PremiumVideoPlayerStatus.initializing;
    errorMessage = null;
    duration = null;
    notifyListeners();

    try {
      final dataSource = _buildDataSource();

      final configuration = _buildConfiguration(
        autoPlay: autoPlay,
      );

      final controller = BetterPlayerController(configuration);

      controller.addEventsListener(_handlePlayerEvent);

      betterPlayerController = controller;

      await controller.setupDataSource(dataSource);

      if (controller.isVideoInitialized()!=null && controller.isVideoInitialized()!) {
        _handleInitialized();
      }
    } catch (e, stackTrace) {
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
      videoFormat:
          isHls ? BetterPlayerVideoFormat.hls : null,
      useAsmsTracks: isHls,
      useAsmsAudioTracks: isHls,
      useAsmsSubtitles: isHls,
      liveStream: false,
    );
  }

  BetterPlayerConfiguration _buildConfiguration({
    required bool autoPlay,
  }) {
    return BetterPlayerConfiguration(
      autoPlay: autoPlay,
      looping: false,
      allowedScreenSleep: false,
      fit: BoxFit.contain,
      aspectRatio: _aspectRatio,

      showPlaceholderUntilPlay: true,

      controlsConfiguration: const BetterPlayerControlsConfiguration(
        showControls: true,
        showControlsOnInitialize: true,

        enablePlayPause: true,
        enableFullscreen: true,
        enableMute: true,
        enableSkips: true,
        enablePlaybackSpeed: true,
        enableQualities: true,
        enableRetry: true,

        enableProgressBar: true,
        enableProgressBarDrag: true,
        enableProgressText: true,
        enableOverflowMenu: true,

        controlsHideTime: Duration(seconds: 4),

        forwardSkipTimeInMilliseconds: 10000,
        backwardSkipTimeInMilliseconds: 10000,

        controlBarHeight: 46,
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

      case BetterPlayerEventType.changedResolution:
        notifyListeners();
        break;

      case BetterPlayerEventType.bufferingStart:
      case BetterPlayerEventType.bufferingEnd:
        notifyListeners();
        break;

      default:
        break;
    }
  }

  void _handleInitialized() {
    final playerController = betterPlayerController;

    if (playerController == null) {
      _setFailure();
      return;
    }

    final videoValue =
        playerController.videoPlayerController?.value;

    final videoDuration = videoValue?.duration;

    if (videoDuration != null &&
        videoDuration != Duration.zero) {
      duration = videoDuration;
    }

    final videoSize = videoValue?.size;

    if (videoSize != null &&
        videoSize.width > 0 &&
        videoSize.height > 0) {
      _aspectRatio = videoSize.width / videoSize.height;
    }

    status = PremiumVideoPlayerStatus.ready;
    errorMessage = null;

    notifyListeners();
  }

  Future<void> retry() async {
    if (_videoUrl == null && _file == null) {
      return;
    }

    await initializeVideo(
      videoUrl: _videoUrl,
      file: _file,
      autoPlay: _autoPlay,
      aspectRatio: _aspectRatio,
    );
  }

  Future<void> play() async {
    await betterPlayerController?.play();
  }

  Future<void> pause() async {
    await betterPlayerController?.pause();
  }

  Future<void> seekTo(Duration position) async {
    await betterPlayerController?.seekTo(position);
  }

  Future<void> setSpeed(double speed) async {
    await betterPlayerController?.setSpeed(speed);
  }

  Future<void> changeResolution(String url) async {
    await betterPlayerController?.setResolution(url);
  }

  Future<void> _disposeCurrentPlayer() async {
    final controller = betterPlayerController;

    if (controller == null) {
      return;
    }

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

    if (uri == null) {
      return false;
    }

    return uri.path.toLowerCase().endsWith('.m3u8');
  }

  @override
  void dispose() {
    final controller = betterPlayerController;

    if (controller != null) {
      controller.removeEventsListener(_handlePlayerEvent);
      controller.dispose(forceDispose: true);
    }

    betterPlayerController = null;

    super.dispose();
  }
}