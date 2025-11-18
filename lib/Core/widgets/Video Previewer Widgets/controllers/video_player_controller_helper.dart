import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/Video Previewer Widgets/Widgets/CustomVideoControllerErrorWidget.dart';
import 'package:sintir/Core/widgets/Video Previewer Widgets/Widgets/CustomVideoControllerPlaceHolder.dart';
import 'package:video_player/video_player.dart';

class CustomVideoController {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  bool _wasPlayingBefore = false;
  bool isInitialized = false;

  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    ValueChanged<Duration>? onDurationChanged,
    required VoidCallback? onUpdate,
  }) async {
    try {
      if (file != null) {
        videoPlayerController = VideoPlayerController.file(file);
      } else if (videoUrl != null) {
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      } else {
        throw Exception("لا يمكن تشغيل الفيديو: لا يوجد رابط أو ملف");
      }
      await videoPlayerController!.initialize();
      // Notify duration (important)
      if (onDurationChanged != null) {
        onDurationChanged(videoPlayerController!.value.duration);
      }

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: false,
        showControls: true,
        allowFullScreen: true,
        allowMuting: true,
        allowedScreenSleep: false,
        allowPlaybackSpeedChanging: true,
        aspectRatio: videoPlayerController!.value.aspectRatio == 0
            ? 16 / 9
            : videoPlayerController!.value.aspectRatio,
        showOptions: true,
        playbackSpeeds: const [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2],

        // Custom Options
        additionalOptions: (context) => <OptionItem>[
          OptionItem(
            onTap: (context) => videoPlayerController?.pause(),
            iconData: Icons.pause,
            title: 'إيقاف',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController?.play(),
            iconData: Icons.play_arrow,
            title: 'تشغيل',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController?.seekTo(Duration.zero),
            iconData: Icons.restart_alt,
            title: 'إعادة التشغيل',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController?.setPlaybackSpeed(1),
            iconData: Icons.speed,
            title: 'سرعة 1x',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController?.setVolume(0),
            iconData: Icons.volume_off,
            title: 'كتم الصوت',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController?.setVolume(1),
            iconData: Icons.volume_up,
            title: 'تشغيل الصوت',
          ),
          OptionItem(
            onTap: (context) {
              final currentSpeed =
                  videoPlayerController?.value.playbackSpeed ?? 1;
              double newSpeed = currentSpeed == 1 ? 1.5 : 1;
              videoPlayerController?.setPlaybackSpeed(newSpeed);

              CustomSnackBar.show(
                context,
                message: "تم تغيير السرعة إلى $newSpeed",
                type: SnackType.success,
              );
            },
            iconData: Icons.speed_outlined,
            title: 'تبديل السرعة',
          ),
        ],

        placeholder: const CustomVideoControllerPlaceHolder(),
        errorBuilder: (context, errorMessage) =>
            const CustomVideoControllerErrorWidget(),

        // Fix Android infinite loading
        progressIndicatorDelay: Platform.isAndroid ? Duration.zero : null,
      );

      videoPlayerController!.addListener(() {
        if (videoPlayerController == null) return;
        _wasPlayingBefore = videoPlayerController!.value.isPlaying;
      });

      isInitialized = true;
      onUpdate?.call();
    } catch (e) {
      rethrow;
    }
  }

  // -----------------------------
  // Clean Dispose
  // -----------------------------
  void dispose() {
    chewieController?.dispose();
    videoPlayerController?.dispose();
    chewieController = null;
    videoPlayerController = null;
    isInitialized = false;
  }
}
