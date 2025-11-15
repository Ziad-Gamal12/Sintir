import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/Widgets/CustomVideoControllerErrorWidget.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/Widgets/CustomVideoControllerPlaceHolder.dart';
import 'package:video_player/video_player.dart';

class CustomVideoController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  bool _wasPlayingBefore = false;

  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    ValueChanged<Duration>? onDurationChanged,
    required void Function()? onUpdate,
  }) async {
    try {
      if (file != null) {
        videoPlayerController = VideoPlayerController.file(file);
      } else if (videoUrl != null) {
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      } else {
        throw Exception("لا يمكن تشغيل الفيديو");
      }

      await videoPlayerController.initialize();

      if (onDurationChanged != null) {
        onDurationChanged(videoPlayerController.value.duration);
      }
      videoPlayerController.addListener(() {
        if (!videoPlayerController.value.isPlaying && !_wasPlayingBefore) {
          if (Platform.isAndroid) videoPlayerController.play();
        }
        _wasPlayingBefore = videoPlayerController.value.isPlaying;
      });

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false, // modern UX: avoid auto-loop unless needed
        showControls: true,
        allowFullScreen: true,
        allowMuting: true,
        allowedScreenSleep: false,
        allowPlaybackSpeedChanging: true,
        aspectRatio: 16 / 9,
        zoomAndPan: true,
        showOptions: true,
        playbackSpeeds: [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2],
        additionalOptions: (context) => <OptionItem>[
          OptionItem(
            onTap: (context) => videoPlayerController.pause(),
            iconData: Icons.pause,
            title: 'إيقاف',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController.play(),
            iconData: Icons.play_arrow,
            title: 'تشغيل',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController.seekTo(Duration.zero),
            iconData: Icons.restart_alt,
            title: 'إعادة التشغيل',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController.setPlaybackSpeed(1),
            iconData: Icons.speed,
            title: 'السرعة الافتراضية',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController.setVolume(0),
            iconData: Icons.volume_off,
            title: 'كتم الصوت',
          ),
          OptionItem(
            onTap: (context) => videoPlayerController.setVolume(1),
            iconData: Icons.volume_up,
            title: 'تشغيل الصوت',
          ),
          OptionItem(
            onTap: (context) {
              final currentSpeed = videoPlayerController.value.playbackSpeed;
              double newSpeed = currentSpeed == 1 ? 1.5 : 1; // toggle
              videoPlayerController.setPlaybackSpeed(newSpeed);
              CustomSnackBar.show(context,
                  message: "تم تغيير السرعة الى $newSpeed",
                  type: SnackType.success);
            },
            iconData: Icons.speed_outlined,
            title: 'تغيير السرعة',
          ),
        ],
        controlsSafeAreaMinimum: const EdgeInsets.only(top: 8, bottom: 8),
        customControls: const MaterialControls(
          showPlayButton: true, // modern play/pause
        ),
        placeholder: const CustomVideoControllerPlaceHolder(),
        errorBuilder: (context, errorMessage) =>
            const CustomVideoControllerErrorWidget(),
        progressIndicatorDelay:
            Platform.isAndroid ? const Duration(days: 1) : null,
        showControlsOnInitialize: false, // optional: controls appear after tap
      );

      onUpdate?.call();
    } catch (e) {
      log("Video Initialization Error: $e");
      rethrow;
    }
  }

  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
