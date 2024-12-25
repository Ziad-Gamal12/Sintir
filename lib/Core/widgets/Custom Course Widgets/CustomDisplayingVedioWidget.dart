import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomVedioErrorWidget.dart';

class Customdisplayingvediowidget extends StatefulWidget {
  const Customdisplayingvediowidget({super.key, required this.vedioUrl});
  final String vedioUrl;
  @override
  State<Customdisplayingvediowidget> createState() =>
      _CustomdisplayingvediowidgetState();
}

class _CustomdisplayingvediowidgetState
    extends State<Customdisplayingvediowidget> {
  late BetterPlayerController betterPlayerController;
  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.vedioUrl,
    );
    var betterPlayerController2 = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: CustomVedioErrorWidget(
              errorMessage: errorMessage,
            ),
          );
        },
        controlsConfiguration: const BetterPlayerControlsConfiguration(
            enableFullscreen: true,
            enablePlaybackSpeed: true,
            playbackSpeedIcon: Icons.slow_motion_video,
            enableSkips: true,
            enableQualities: true,
            backwardSkipTimeInMilliseconds: 600,
            enableMute: true,
            enableProgressBar: true,
            enablePlayPause: true),
      ),
      betterPlayerDataSource: dataSource,
    );
    betterPlayerController = betterPlayerController2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BetterPlayer(
        controller: betterPlayerController,
      ),
    );
  }
}
