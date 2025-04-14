import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestControlPanel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestQuestionsNavigation.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestquestionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/TestQuestionNavigationButtons.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CoursetestviewBody extends StatefulWidget {
  const CoursetestviewBody({super.key, required this.coursetestentity});
  final Coursetestentity coursetestentity;
  @override
  State<CoursetestviewBody> createState() => _CoursetestviewBodyState();
}

class _CoursetestviewBodyState extends State<CoursetestviewBody> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);
  @override
  void initState() {
    widget.coursetestentity.questions[0].isOpened = true;
    stopWatchTimer.setPresetMinuteTime(widget.coursetestentity.durationTime);
    stopWatchTimer.onStartTimer();
    super.initState();
  }

  int currentQuestionIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.coursetestentity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 20),
        child: ListView(
          children: [
            CourseTestControlPanel(
                totalTime: widget.coursetestentity.durationTime * 1.0,
                stopWatchTimer: stopWatchTimer,
                widget: widget),
            Coursetestquestionsnavigation(
              currentQuestionIndex: currentQuestionIndex,
              widget: widget,
              selectQuestionAction: (value) {
                currentQuestionIndex = value;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            CoursetestquestionItem(
                coursetestentity: widget.coursetestentity,
                currentQuestionIndex: currentQuestionIndex,
                answerChange: (answer) {
                  widget.coursetestentity.questions[currentQuestionIndex]
                      .selectedSolution = answer ?? "";
                  setState(() {});
                },
                selectedAnswer: widget.coursetestentity
                        .questions[currentQuestionIndex].selectedSolution ??
                    ""),
            const SizedBox(
              height: 20,
            ),
            TestQuestionNavigationButtons(
              nextQuestion: () {
                if (currentQuestionIndex <
                    widget.coursetestentity.questions.length - 1) {
                  currentQuestionIndex++;
                  widget.coursetestentity.questions[currentQuestionIndex]
                      .isOpened = true;
                  selectedAnswer = "";
                  setState(() {});
                }
              },
              previousQuestion: () {
                if (currentQuestionIndex > 0) {
                  currentQuestionIndex--;
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
