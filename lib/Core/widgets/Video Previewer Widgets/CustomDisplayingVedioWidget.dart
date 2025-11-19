import 'dart:developer';
import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/controllers/video_player_controller_helper.dart';

class PremiumVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final File? file;
  final ValueChanged<Duration>? onDurationChanged;

  const PremiumVideoPlayer({
    super.key,
    this.videoUrl,
    this.file,
    this.onDurationChanged,
  });

  @override
  State<PremiumVideoPlayer> createState() => _PremiumVideoPlayerState();
}

class _PremiumVideoPlayerState extends State<PremiumVideoPlayer> {
  final CustomVideoControllerBetter _controller = CustomVideoControllerBetter();
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      await _controller.initializeVideo(
        videoUrl: widget.videoUrl,
        file: widget.file,
        context: context,
        onUpdate: () {
          if (mounted) setState(() => _isLoading = false);
        },
        onDurationChanged: widget.onDurationChanged ?? (_) {},
      );
    } catch (e, s) {
      log("PremiumVideoPlayer Error: $e", stackTrace: s);
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Custom_Loading_Widget(isLoading: true, child: SizedBox());
    }

    if (_hasError || !_controller.isInitialized) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.red),
            SizedBox(height: 8),
            Text("فشل تحميل الفيديو"),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          controller: _controller.betterPlayerController!,
        ),
      ),
    );
  }
}
