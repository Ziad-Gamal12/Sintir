import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerDisplay extends StatefulWidget {
  final Stream<int> timerStream;
  final StopWatchTimer stopWatchTimer;
  const TimerDisplay({
    super.key,
    required this.timerStream,
    required this.stopWatchTimer,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Stream<int> _rawTimeStream;

  @override
  void initState() {
    super.initState();
    _rawTimeStream = widget.stopWatchTimer.rawTime.asBroadcastStream();
  }

  double _calculateProgress(int rawTime, double totalTime) {
    final currentMinutes = (rawTime / 60000).truncate().toDouble();
    return currentMinutes / totalTime;
  }

  Color getProgressColor(double progress) {
    if (progress < .25) {
      return Colors.red;
    } else if (progress < .5) {
      return Colors.yellow;
    } else {
      return KMainColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    CourseTestEntity test =
        context.read<Coursetestviewnavigationsrequirmentsentity>().test;
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            radius: 50,
            child: StreamBuilder<int>(
              stream: widget.timerStream,
              builder: (context, snap) {
                final value = snap.data ?? 0;
                final displayTime = StopWatchTimer.getDisplayTime(value,
                    hours: true,
                    minute: true,
                    milliSecond: false,
                    second: false);
                return Text(
                  displayTime,
                  style: AppTextStyles(context)
                      .bold24
                      .copyWith(color: Colors.black),
                );
              },
            ),
          ),
          StreamBuilder<int>(
            stream: _rawTimeStream,
            builder: (context, snapshot) {
              final rawTime = snapshot.data ?? 0;
              final progress =
                  _calculateProgress(rawTime, test.durationTime * 1.0);
              return CircularProgressIndicator(
                strokeWidth: 8,
                color: getProgressColor(progress),
                value: progress,
              );
            },
          ),
        ],
      ),
    );
  }
}
