import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Coursetestviewbodytimer extends StatefulWidget {
  const Coursetestviewbodytimer({super.key, required this.durationSeconds});
  final int durationSeconds;

  @override
  State<Coursetestviewbodytimer> createState() =>
      _CoursetestviewbodytimerState();
}

class _CoursetestviewbodytimerState extends State<Coursetestviewbodytimer> {
  late StopWatchTimer _stopWatchTimer;
  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromMinute(
          widget.durationSeconds), // millisecond => minute.
    );
    _stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 100),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      decoration: BoxDecoration(
          color: KMainColor, borderRadius: BorderRadius.circular(10)),
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: 0,
        builder: (context, snap) {
          final value = snap.data;
          final displayTime = StopWatchTimer.getDisplayTime(value!);
          return Text(
            displayTime,
            style: AppTextStyles.bold24.copyWith(color: Colors.white),
          );
        },
      ),
    );
  }
}
