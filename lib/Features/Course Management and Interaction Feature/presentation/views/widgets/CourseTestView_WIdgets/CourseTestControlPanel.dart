import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/question_stats_row.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/test_timer_and_actions_row.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CourseTestControlPanel extends StatelessWidget {
  const CourseTestControlPanel({
    super.key,
    required this.stopWatchTimer,
    required this.exam,
  });

  final StopWatchTimer stopWatchTimer;
  final CourseTestEntity exam;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 50,
            spreadRadius: 1,
            offset: const Offset(5, 15),
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          /// Displays question stats (total, answered, unanswered)
          QuestionStatsRow(exam: exam),

          const SizedBox(height: 10),

          /// Displays timer + test action buttons
          TestTimerAndActionsRow(stopWatchTimer: stopWatchTimer),
        ],
      ),
    );
  }
}
