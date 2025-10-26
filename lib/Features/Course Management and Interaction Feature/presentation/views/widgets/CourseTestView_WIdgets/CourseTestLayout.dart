import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestControlPanel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/QuestionNavigationBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/test_loading_overlay.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/test_question_display.dart';
import 'package:sintir/constant.dart';

class CourseTestLayout extends StatefulWidget {
  const CourseTestLayout({
    super.key,
    required this.test,
    required this.stopWatchTimer,
    required this.currentQuestionIndex,
    required this.onQuestionChanged,
  });

  final CourseTestEntity test;
  final dynamic stopWatchTimer;
  final int currentQuestionIndex;
  final ValueChanged<int> onQuestionChanged;

  @override
  State<CourseTestLayout> createState() => _CourseTestLayoutState();
}

class _CourseTestLayoutState extends State<CourseTestLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Question display
              TestQuestionDisplay(
                test: widget.test,
                currentQuestionIndex: widget.currentQuestionIndex,
                onAnswerSelected: (answer) {
                  widget.test.questions[widget.currentQuestionIndex]
                      .selectedSolution = answer;
                  setState(() {});
                  if (widget.currentQuestionIndex <
                      widget.test.questions.length - 1) {
                    widget.onQuestionChanged(widget.currentQuestionIndex + 1);
                    setState(() {
                      widget.test.questions[widget.currentQuestionIndex + 1]
                          .isOpened = true;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              /// Question navigation bar
              QuestionNavigationBar(
                currentIndex: widget.currentQuestionIndex,
                onSelect: widget.onQuestionChanged,
              ),

              const Spacer(),

              /// Control panel (timer + stats + buttons)
              CourseTestControlPanel(
                  stopWatchTimer: widget.stopWatchTimer, exam: widget.test),
            ],
          ),
        ),

        /// Loading overlay
        const TestLoadingOverlay(),
      ],
    );
  }
}
