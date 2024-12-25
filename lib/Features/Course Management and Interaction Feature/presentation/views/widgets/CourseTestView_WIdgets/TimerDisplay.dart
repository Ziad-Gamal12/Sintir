import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerDisplay extends StatelessWidget {
  final Stream<int> timerStream;

  const TimerDisplay({super.key, required this.timerStream});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 100),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        decoration: BoxDecoration(
            color: KMainColor, borderRadius: BorderRadius.circular(10)),
        child: StreamBuilder<int>(
          stream: timerStream,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(value!);
            return Text(
              displayTime,
              style: AppTextStyles.bold24.copyWith(color: Colors.white),
            );
          },
        ));
  }
}
