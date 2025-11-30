// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/locale_keys.dart';

class CustomVideoControllerBetter {
  BetterPlayerController? betterPlayerController;
  bool isInitialized = false;

  Future<void> initializeVideo({
    required String? videoUrl,
    required File? file,
    required VoidCallback? onUpdate,
    ValueChanged<Duration>? onDurationChanged,
    BuildContext? context,
  }) async {
    try {
      if (videoUrl == null && file == null) {
        throw Exception(LocaleKeys.videoLoadFailed);
      }

      BetterPlayerDataSource dataSource;
      if (file != null) {
        dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.file,
          file.path,
        );
      } else {
        dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          videoUrl!,
        );
      }

      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        allowedScreenSleep: false,
        fit: BoxFit.contain,
        aspectRatio: 16 / 9,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enablePlaybackSpeed: true,
          enableSkips: true,
          enableFullscreen: true,
          enableMute: true,
        ),
        errorBuilder: (context, errorMessage) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.videoFailed,
            type: SnackType.error,
          );
          return Center(
              child: Text(
            LocaleKeys.videoPlayFailed,
            style: const TextStyle(color: Colors.white),
          ));
        },
      );

      betterPlayerController =
          BetterPlayerController(betterPlayerConfiguration);

      await betterPlayerController!.setupDataSource(dataSource);

      if (onDurationChanged != null) {
        final duration =
            betterPlayerController!.videoPlayerController?.value.duration;
        if (duration != null) onDurationChanged(duration);
      }

      isInitialized = true;
      onUpdate?.call();
    } catch (e) {
      if (context != null) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.videoNotSupported,
          type: SnackType.error,
        );
      }
      isInitialized = false;
      onUpdate?.call();
      debugPrint("⚠️ CustomVideoControllerBetter Error: $e");
    }
  }

  void dispose() {
    betterPlayerController?.dispose();
    betterPlayerController = null;
    isInitialized = false;
  }
}
