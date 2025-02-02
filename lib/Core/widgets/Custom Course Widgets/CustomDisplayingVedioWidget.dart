import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomVedioErrorWidget.dart';
import 'package:video_player/video_player.dart';

class Customdisplayingvediowidget extends StatefulWidget {
  const Customdisplayingvediowidget({super.key, required this.vedioUrl});
  final String vedioUrl;
  @override
  State<Customdisplayingvediowidget> createState() =>
      _CustomdisplayingvediowidgetState();
}

class _CustomdisplayingvediowidgetState
    extends State<Customdisplayingvediowidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.vedioUrl));
    videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      playbackSpeeds: [0.5, 1.0, 1.5, 2.0],
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return CustomVedioErrorWidget(
          errorMessage: errorMessage,
        );
      },
      autoPlay: true,
      looping: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Chewie(
        controller: chewieController,
      ),
    );
  }
}
