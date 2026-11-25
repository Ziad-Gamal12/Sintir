import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/customSolutionStateCheckBoxWidget.dart';

/// A check/cross mark followed by an answer that wraps onto as many lines as
/// it needs, its first line centred on the mark.
class CustomSolutionStateRowWidget extends StatelessWidget {
  const CustomSolutionStateRowWidget({
    super.key,
    required this.isCorrect,
    required this.title,
    this.isPlaceholder = false,
  });
  final bool isCorrect;
  final String title;

  /// [title] stands in for a missing answer, so it is muted.
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyLarge!.color!;
    final style = AppTextStyles(context).semiBold16.copyWith(
      color: isPlaceholder ? textColor.withValues(alpha: 0.55) : textColor,
      fontStyle: isPlaceholder ? FontStyle.italic : null,
      height: 1.35,
    );

    // Pads the text so a one-line answer is centred on the mark.
    final lineHeight = (style.fontSize ?? 16) * (style.height ?? 1);
    final topInset = ((Customsolutionstatecheckboxwidget.size - lineHeight) / 2)
        .clamp(0.0, double.infinity);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customsolutionstatecheckboxwidget(isCorrect: isCorrect),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: topInset),
            child: Text(title, style: style),
          ),
        ),
      ],
    );
  }
}
