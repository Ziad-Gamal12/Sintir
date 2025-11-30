import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
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
  bool _resultSent = false;

  @override
  void initState() {
    super.initState();
    _rawTimeStream = widget.stopWatchTimer.rawTime.asBroadcastStream();

    _rawTimeStream.listen((rawTime) {
      final remainingSeconds = rawTime / 1000;
      if (remainingSeconds <= 0 && !_resultSent) {
        _resultSent = true;

        if (mounted) {
          final requirements =
              context.read<CourseExamViewNavigationsRequirmentsEntity>();

          widget.stopWatchTimer.onStopTimer();

          context.read<TestItemCubit>().addTestResults(
                context: context,
                test: requirements.test,
                userId: getUserData().uid,
                sectionId: requirements.sectionId,
                sectionItemId: requirements.test.id,
                courseId: requirements.course.id,
              );
        }
      }
    });
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
  void dispose() {
    _rawTimeStream.drain();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final test =
        context.read<CourseExamViewNavigationsRequirmentsEntity>().test;

    return SizedBox(
      height: MediaQuery.of(context).size.width * .16,
      width: MediaQuery.of(context).size.width * .16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * .09,
            backgroundColor: Colors.white,
            child: StreamBuilder<int>(
              stream: widget.timerStream,
              builder: (context, snap) {
                final value = snap.data ?? 0;
                final displayTime = StopWatchTimer.getDisplayTime(
                  value,
                  hours: true,
                  minute: true,
                  second: true,
                  milliSecond: false,
                );
                return Text(
                  displayTime,
                  style: AppTextStyles(context)
                      .regular13
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
