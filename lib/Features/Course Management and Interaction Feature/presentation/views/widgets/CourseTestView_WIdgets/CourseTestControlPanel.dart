import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyQuestionsInfo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyTestButtonsActions.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/TimerDisplay.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CourseTestControlPanel extends StatelessWidget {
  const CourseTestControlPanel({
    super.key,
    required this.stopWatchTimer,
    required this.widget,
  });

  final StopWatchTimer stopWatchTimer;
  final CoursetestviewBody widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TimerDisplay(
            stopWatchTimer: stopWatchTimer,
            timerStream: stopWatchTimer.rawTime,
          ),
          const SizedBox(
            height: 20,
          ),
          const CourseTestViewBodyTestButtonsActions(),
          const SizedBox(
            height: 20,
          ),
          CourseTestViewBodyQuestionsInfo(),
        ],
      ),
    );
  }
}
