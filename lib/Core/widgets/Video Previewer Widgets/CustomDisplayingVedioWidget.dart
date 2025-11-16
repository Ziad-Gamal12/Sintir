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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initVideo());
  }

  Future<void> _initVideo() async {
    try {
      await _controller.initializeVideo(
        videoUrl: widget.videoUrl,
        file: widget.file,
        onUpdate: () {
          setState(() => _isLoading = false);
        },
        onDurationChanged: widget.onDurationChanged ?? (_) {},
      );
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _controller.chewieController == null) {
      return const Custom_Loading_Widget(isLoading: true, child: SizedBox());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: _controller.chewieController!),
      ),
    );
  }
}
