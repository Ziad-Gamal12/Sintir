import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
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
  final CustomVideoController _controller = CustomVideoController();
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
        onUpdate: () {
          if (mounted) setState(() => _isLoading = false);
        },
        onDurationChanged: widget.onDurationChanged ?? (_) {},
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
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
        aspectRatio: _controller.videoPlayerController!.value.aspectRatio == 0
            ? 16 / 9
            : _controller.videoPlayerController!.value.aspectRatio,
        child: Chewie(controller: _controller.chewieController!),
      ),
    );
  }
}
