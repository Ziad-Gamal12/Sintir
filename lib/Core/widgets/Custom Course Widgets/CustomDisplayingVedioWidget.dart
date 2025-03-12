import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:video_player/video_player.dart';

class Customdisplayingvediowidget extends StatefulWidget {
  Customdisplayingvediowidget({super.key, this.videoUrl, this.file});
  String? videoUrl;
  File? file;
  @override
  State<Customdisplayingvediowidget> createState() =>
      _CustomdisplayingvediowidgetState();
}

class _CustomdisplayingvediowidgetState
    extends State<Customdisplayingvediowidget> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    initVedioController(context);
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
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(
                videoPlayerController,
              ))
          : Custom_Loading_Widget(
              isLoading: videoPlayerController.value.isInitialized == false,
              child: const SizedBox()),
    );
  }

  Future<void> initVedioController(BuildContext context) async {
    try {
      if (widget.file != null) {
        videoPlayerController = VideoPlayerController.file(
          widget.file!,
          videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
        );
      } else if (widget.videoUrl != null) {
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.videoUrl!),
          videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
        );
      } else {
        showSnackBar(context, "حدث خطأ فى العنصر");
      }

      await videoPlayerController.initialize();
      setState(() {});
    } catch (e) {
      log("Video Initialization Error: $e");
    }
  }

  disposeControllers() async {
    videoPlayerController.dispose();
  }
}
