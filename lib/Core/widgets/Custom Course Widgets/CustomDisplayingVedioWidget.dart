import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:video_player/video_player.dart';

class Customdisplayingvediowidget extends StatefulWidget {
  const Customdisplayingvediowidget({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<Customdisplayingvediowidget> createState() =>
      _CustomdisplayingvediowidgetState();
}

class _CustomdisplayingvediowidgetState
    extends State<Customdisplayingvediowidget> {
  late VideoPlayerController videoController;
  ChewieController? chewieController;
  @override
  void initState() {
    initVedioController();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: 16 / 9, child: Chewie(controller: chewieController!))
          : Custom_Loading_Widget(
              isLoading: chewieController == null, child: const SizedBox()),
    );
  }

  Future<void> initVedioController() async {
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await videoController
          .initialize(); // Ensure video is initialized before proceeding
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: false,
        );
      });
    } catch (e) {
      log("Video Initialization Error: $e");
    }
  }

  disposeControllers() async {
    await videoController.dispose();
    chewieController?.dispose();
  }
}
