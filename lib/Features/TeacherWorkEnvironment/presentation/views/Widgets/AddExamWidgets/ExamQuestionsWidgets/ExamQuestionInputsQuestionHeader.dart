import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// "Question 2 of 5", with an optional [trailing] status. The status sits at
/// the end of the line when it fits and drops below the title when it doesn't.
class ExamQuestionInputsQuestionHeader extends StatelessWidget {
  const ExamQuestionInputsQuestionHeader({
    super.key,
    required this.index,
    required this.totalQuestions,
    this.trailing,
  });

  final int index;
  final int totalQuestions;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    final accent = theme.colorScheme.primary;
    final muted = WorkEnvironmentThemeExtension.of(context).mutedText;

    final title = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${LocaleKeys.questionNumber} ",
            style: styles.semiBold16.copyWith(color: textColor),
          ),
          TextSpan(
            text: "${index + 1}",
            style: styles.bold16.copyWith(color: accent),
          ),
          TextSpan(
            text: " ${LocaleKeys.of} $totalQuestions",
            style: styles.regular16.copyWith(color: muted),
          ),
        ],
      ),
    );

    return Row(
      children: [
        FaIcon(FontAwesomeIcons.circleInfo, color: accent, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [title, ?trailing],
          ),
        ),
      ],
    );
  }
}
