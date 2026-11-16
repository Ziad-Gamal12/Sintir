import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/assessment_score_ring.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/assessment_status_chip.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_date_formatter.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_status_mapper.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class AssessmentResultCard extends StatelessWidget {
  const AssessmentResultCard({
    super.key,
    required this.result,
    this.onViewResult,
  });
  final TestResultEntity result;
  final VoidCallback? onViewResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final tokens = ResultsTokens.of(theme);
    final percent = ResultsStatusMapper.percentage(result);
    final outcome = ResultsStatusMapper.outcome(result, theme);
    final earned = result.questionsSolvedListEntity
        .where((q) => q.isCorrect)
        .length;

    final name = result.testName.trim();
    final subject = result.courseSubject.trim();
    final title = name.isNotEmpty
        ? name
        : (subject.isNotEmpty
              ? subject
              : LocaleKeys.resultsAssessmentFallback(result.testId));

    final locale = Localizations.localeOf(context).toString();
    final d = result.joinedDate;
    final date =
        '${ResultsDateFormatter.number(context, d.day)} '
        '${DateFormat.MMM(locale).format(d)} ${d.year}';
    final showSubject = name.isNotEmpty && subject.isNotEmpty;
    final captionStyle = style.regular13.copyWith(color: tokens.muted);
    final score =
        '${ResultsDateFormatter.number(context, earned)}/'
        '${ResultsDateFormatter.number(context, result.totalQuestions)} '
        '${LocaleKeys.correctAnswers}';

    void openReview() {
      if (onViewResult != null) {
        onViewResult!.call();
      } else {
        GoRouter.of(
          context,
        ).push(Reviewtestresultview.routeName, extra: result);
      }
    }

    return Semantics(
      button: true,
      label: '$title, ${outcome.label}, $score',
      child: Material(
        color: tokens.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: tokens.border),
        ),
        child: InkWell(
          onTap: openReview,
          mouseCursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AssessmentScoreRing(percent: percent, color: outcome.color),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: style.semiBold16.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          if (showSubject) ...[
                            Flexible(
                              child: Text(
                                subject,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: captionStyle,
                              ),
                            ),
                            Text('  •  ', style: captionStyle),
                          ],
                          Text(date, maxLines: 1, style: captionStyle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          AssessmentStatusChip(status: outcome),
                          Text(
                            score,
                            style: style.regular13.copyWith(
                              color: tokens.muted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: tokens.muted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
