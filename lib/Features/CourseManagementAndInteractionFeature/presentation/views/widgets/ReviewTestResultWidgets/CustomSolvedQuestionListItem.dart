import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemContent.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemHeader.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemQuestionTitle%20.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/ShowHideSolutionButton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/SolutionImagePanel.dart';

/// One reviewed question: header, title, the student's and correct answers,
/// the question image, and the teacher's explanation image when there is one.
///
/// The card takes the height its content needs. From [Breakpoints.medium]
/// card width up (tablets), the question image sits beside the answers;
/// below it, the image is stacked above them.
class CustomSolvedQuestionListItem extends StatefulWidget {
  const CustomSolvedQuestionListItem({
    super.key,
    required this.questionEntity,
    required this.index,
    required this.length,
  });

  final ExamResultSolvedQuestionEntity questionEntity;
  final int index;
  final int length;

  @override
  State<CustomSolvedQuestionListItem> createState() =>
      _CustomSolvedQuestionListItemState();
}

class _CustomSolvedQuestionListItemState
    extends State<CustomSolvedQuestionListItem> {
  bool isSolutionVisible = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.questionEntity.question;
    final solutionImageUrl = question.solutionImageUrl;
    final hasSolutionImage =
        solutionImageUrl != null && solutionImageUrl.isNotEmpty;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = widget.questionEntity.isCorrect
        ? Colors.green.shade400
        : Colors.red.shade400;
    final backgroundColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.medium;
        final padding = isWide ? 20.0 : 14.0;

        return Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 1.2),
            borderRadius: BorderRadius.circular(isWide ? 16 : 12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomSolvedQuestionListItemHeader(
                index: widget.index,
                length: widget.length,
                isCorrect: widget.questionEntity.isCorrect,
              ),
              const SizedBox(height: 12),
              CustomSolvedQuestionListItemQuestionTitle(
                questionTitle: question.questionTitle ?? '',
                isWide: isWide,
              ),
              const SizedBox(height: 12),
              CustomSolvedQuestionListItemContent(
                examResultSolvedQuestionEntity: widget.questionEntity,
                isWide: isWide,
              ),
              if (hasSolutionImage) ...[
                const SizedBox(height: 14),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ShowHideSolutionButton(
                    isVisible: isSolutionVisible,
                    onTap: () {
                      setState(() => isSolutionVisible = !isSolutionVisible);
                    },
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  alignment: AlignmentDirectional.topCenter,
                  child: isSolutionVisible
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SolutionImagePanel(
                            imageUrl: solutionImageUrl,
                            maxHeight: isWide ? 480 : 360,
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
