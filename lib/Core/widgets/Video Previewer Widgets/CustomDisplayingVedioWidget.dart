// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomVedioErrorWidget.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:video_player/video_player.dart';

class CustomDisplayingVideoWidget extends StatefulWidget {
  CustomDisplayingVideoWidget(
      {super.key, this.videoUrl, this.file, this.durtationChanged});
  final String? videoUrl;
  final File? file;
  ValueChanged<int>? durtationChanged;

  @override
  State<CustomDisplayingVideoWidget> createState() =>
      _CustomDisplayingVideoWidgetState();
}

class _CustomDisplayingVideoWidgetState
    extends State<CustomDisplayingVideoWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    initVideoController();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Future<void> initVideoController() async {
    try {
      if (widget.file != null) {
        videoPlayerController = VideoPlayerController.file(widget.file!);
      } else if (widget.videoUrl != null) {
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
      } else {
        ShowSnackBar(
            context: context,
            child: Text("حدث خطأ فى العنصر",
                style: AppTextStyles.regular14.copyWith(color: Colors.white)),
            backgroundColor: Colors.red);
        return;
      }
      await videoPlayerController.initialize();
      widget.durtationChanged != null
          ? widget
              .durtationChanged!(videoPlayerController.value.duration.inMinutes)
          : null;
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        errorBuilder: (context, errorMessage) {
          return CustomVedioErrorWidget(errorMessage: errorMessage);
        },
        autoPlay: true,
        looping: true,
        showControls: true,
      );
      setState(() {});
    } catch (e) {
      log("Video Initialization Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController.value.isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: chewieController),
        ),
      );
    } else {
      return const Custom_Loading_Widget(
        isLoading: true,
        child: SizedBox(),
      );
    }
  }
}
