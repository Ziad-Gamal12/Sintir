import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

enum PremiumVideoPlayerStatus { idle, initializing, ready, failed }

/// Owns the [VideoPlayerController] behind `PremiumVideoPlayer`: loading,
/// retry, quality switching, speed and keeping the screen awake.
///
/// On Android the video is rendered through a platform view (a native
/// `SurfaceView`) instead of a Flutter texture. On API 29+ the texture path
/// is backed by `ImageReader`, which ignores the decoder's crop rectangle
/// (see `SurfaceProducer.handlesCropAndRotation()` and
/// https://github.com/flutter/flutter/issues/144407). Hardware decoders that
/// pad frames to an aligned size (e.g. 854 px wide → 896 px buffer) then show
/// the uninitialised padding as a green bar on the right or bottom edge.
/// A `SurfaceView` is composited by Android itself, which honours the crop.
class PremiumVideoController extends ChangeNotifier {
  VideoPlayerController? player;

  PremiumVideoPlayerStatus status = PremiumVideoPlayerStatus.idle;
  String? errorMessage;
  Duration? duration;

  /// null = Auto
  int? selectedHeight;
  double speed = 1.0;

  /// Whether playback has started at least once for the current video.
  /// The poster is shown until then.
  bool hasStarted = false;

  double _aspectRatio = 16 / 9;

  String? _videoUrl;
  File? _file;
  bool _autoPlay = false;
  Future<String> Function(int? height)? _urlResolver;

  /// Quality options (e.g. 720, 540, 480, 360), highest first.
  List<int> _qualities = const [];

  /// Position to resume from after a quality switch.
  Duration? _resumeAt;

  bool _disposed = false;
  bool _wakelockOn = false;
  int _session = 0;

  double get aspectRatio => _aspectRatio;
  bool get hasError => status == PremiumVideoPlayerStatus.failed;
  List<int> get qualityHeights => _qualities;

  static VideoViewType get _viewType =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? VideoViewType.platformView
      : VideoViewType.textureView;

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
    List<int> qualities = const [],
    Future<String> Function(int? height)? urlResolver,
    double? aspectRatio,
    bool autoPlay = false,
  }) async {
    _urlResolver = urlResolver;
    _videoUrl = videoUrl;
    _file = file;
    _autoPlay = autoPlay;
    _qualities = qualities;

    if (aspectRatio != null && aspectRatio > 0) _aspectRatio = aspectRatio;

    selectedHeight = null;
    speed = 1.0;
    hasStarted = false;
    _resumeAt = null;

    await _start(play: autoPlay);
  }

  /// Creates a fresh player. Used for the first load, retry and quality
  /// switches.
  Future<void> _start({required bool play}) async {
    final session = ++_session;

    _releasePlayer();

    status = PremiumVideoPlayerStatus.initializing;
    errorMessage = null;
    duration = null;
    notifyListeners();

    try {
      final controller = _createPlayer();
      player = controller;
      controller.addListener(_onPlayerValue);

      await controller.initialize().timeout(const Duration(seconds: 25));
      if (_isStale(session)) return;

      await _handleInitialized(controller, play: play, session: session);
    } catch (_) {
      if (_isStale(session)) return;
      _setFailure();
    }
  }

  VideoPlayerController _createPlayer() {
    final file = _file;
    if (file != null) {
      return VideoPlayerController.file(file, viewType: _viewType);
    }

    final raw = _videoUrl?.trim();
    if (raw == null || raw.isEmpty) {
      throw ArgumentError('A video file or playback URL is required.');
    }

    final url = _withQuality(raw);
    return VideoPlayerController.networkUrl(
      Uri.parse(url),
      formatHint: _isHlsUrl(url) ? VideoFormat.hls : null,
      viewType: _viewType,
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

  Future<void> _handleInitialized(
    VideoPlayerController controller, {
    required bool play,
    required int session,
  }) async {
    final value = controller.value;

    if (value.duration > Duration.zero) duration = value.duration;

    final size = value.size;
    if (size.width > 0 && size.height > 0) {
      _aspectRatio = size.width / size.height;
    }

    // Restore state after a quality switch / retry.
    if (speed != 1.0) await controller.setPlaybackSpeed(speed);

    final resume = _resumeAt;
    _resumeAt = null;
    if (resume != null && resume > Duration.zero) {
      await controller.seekTo(resume);
    }
    if (_isStale(session)) return;

    status = PremiumVideoPlayerStatus.ready;
    errorMessage = null;
    notifyListeners();

    if (play) await controller.play();
  }

  // ───────── player events ─────────

  void _onPlayerValue() {
    final value = player?.value;
    if (value == null) return;

    // Errors during initialize() are handled by _start's catch.
    if (value.hasError && status == PremiumVideoPlayerStatus.ready) {
      _setFailure();
      return;
    }

    _syncWakelock(value.isPlaying);

    if (value.isPlaying && !hasStarted) {
      hasStarted = true;
      notifyListeners();
    }
  }

  /// Keeps the screen on while a video is playing.
  void _syncWakelock(bool on) {
    if (on == _wakelockOn) return;
    _wakelockOn = on;
    unawaited(
      (on ? WakelockPlus.enable() : WakelockPlus.disable()).catchError((_) {}),
    );
  }

  // ───────── actions ─────────

  Future<void> retry() async {
    if (_videoUrl == null && _file == null) return;
    await _start(play: _autoPlay);
  }

  Future<void> play() async => player?.play();
  Future<void> pause() async => player?.pause();
  Future<void> seekTo(Duration p) async => player?.seekTo(p);

  Future<void> setSpeed(double value) async {
    await player?.setPlaybackSpeed(value);
    speed = value;
    notifyListeners();
  }

  /// [height] null = Auto. Rebuilds the player at the same position.
  Future<void> setQuality(int? height) async {
    final current = player;
    if (current == null || height == selectedHeight) return;

    String? freshUrl;
    final resolver = _urlResolver;
    if (resolver != null) {
      try {
        freshUrl = await resolver(height);
      } catch (_) {
        return;
      }
      if (_disposed || player != current) return;
    }

    final wasPlaying = current.value.isPlaying;
    final position = await current.position;
    if (_disposed || player != current) return;

    if (freshUrl != null) _videoUrl = freshUrl;
    selectedHeight = height;
    _resumeAt = position;
    // Show the video frame after a switch, not the poster.
    hasStarted = true;
    await _start(play: wasPlaying);
  }

  // ───────── cleanup ─────────

  void _releasePlayer() {
    final controller = player;
    if (controller == null) return;

    player = null;
    controller.removeListener(_onPlayerValue);
    _syncWakelock(false);
    unawaited(controller.dispose());
  }

  void _setFailure() {
    _syncWakelock(false);
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
    _releasePlayer();
    super.dispose();
  }
}
