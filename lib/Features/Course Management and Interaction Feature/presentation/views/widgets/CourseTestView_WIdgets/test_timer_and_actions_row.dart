import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyTestButtonsActions.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/TimerDisplay.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TestTimerAndActionsRow extends StatelessWidget {
  const TestTimerAndActionsRow({super.key, required this.stopWatchTimer});

  final StopWatchTimer stopWatchTimer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Timer
        TimerDisplay(
          stopWatchTimer: stopWatchTimer,
          timerStream: stopWatchTimer.rawTime,
        ),

        const SizedBox(width: 20),

        /// Buttons
        const Expanded(
          child: CourseTestViewBodyTestButtonsActions(),
        ),
      ],
    );
  }
}
