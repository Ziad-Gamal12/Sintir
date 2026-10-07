import 'dart:io';
import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

/// Owns the local preview of the picked video: first frame, duration, size
/// and play/pause. It lives as long as the file is selected, so it survives
/// the picker switching to the upload progress card and back (no re-decoding).
class VideoPreviewController extends ChangeNotifier {
  VideoPreviewController(this.file, {this.onDurationReady}) {
    _loadFileSize();
    _initializePlayer();
  }

  final File file;
  final ValueChanged<Duration>? onDurationReady;

  late final VideoPlayerController _player = VideoPlayerController.file(file);
  bool _disposed = false;
  bool _isReady = false;
  bool _isPlaying = false;
  int? _fileSizeBytes;

  VideoPlayerController get player => _player;
  bool get isReady => _isReady;
  bool get isPlaying => _isPlaying;
  int? get fileSizeBytes => _fileSizeBytes;
  Duration get duration => _player.value.duration;
  Size get size => _player.value.size;
  String get fileName => file.path.split(Platform.pathSeparator).last;

  Future<void> togglePlay() => _isPlaying ? _player.pause() : _player.play();

  Future<void> pause() async {
    if (_isPlaying) await _player.pause();
  }

  Future<void> _loadFileSize() async {
    try {
      final length = await file.length();
      if (_disposed) return;
      _fileSizeBytes = length;
      notifyListeners();
    } catch (_) {
      // The size label is optional; the upload does not depend on it.
    }
  }

  Future<void> _initializePlayer() async {
    try {
      await _player.initialize();
      if (_disposed) return;
      _player.addListener(_syncPlayingState);
      _isReady = true;
      onDurationReady?.call(duration);
      notifyListeners();
    } catch (_) {
      // The preview is optional; the upload must still work without it.
    }
  }

  void _syncPlayingState() {
    final playing = _player.value.isPlaying;
    if (playing == _isPlaying) return;
    _isPlaying = playing;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _player.removeListener(_syncPlayingState);
    _player.dispose();
    super.dispose();
  }
}
