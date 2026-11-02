import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/assessment_stats_row.dart';
import 'package:sintir/Core/widgets/results/assessment_pass_indicator.dart';
import 'package:sintir/Core/widgets/results/assessment_progress_bar.dart';
import 'package:sintir/Core/widgets/results/results_date_formatter.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Core/widgets/results/results_status_mapper.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/Core/widgets/results/tonal_view_result_button.dart';
import 'package:sintir/locale_keys.dart';

class AssessmentResultCard extends StatelessWidget {
  const AssessmentResultCard({super.key, required this.result, this.onViewResult});
  final TestResultEntity result;
  final VoidCallback? onViewResult;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final tokens = ResultsTokens.of(theme);
    final percent = ResultsStatusMapper.percentage(result);
    final status = ResultsStatusMapper.assessment(percent, theme);
    final earned =
        result.questionsSolvedListEntity.where((item) => item.isCorrect).length;
    final title = result.courseSubject.isEmpty
        ? LocaleKeys.resultsAssessmentFallback(result.testId)
        : result.courseSubject;
    final captionConsistent = result.isPassed == (percent >= 50);
    void openReview() {
      if (onViewResult != null) {
        onViewResult!.call();
      } else {
        GoRouter.of(context)
            .push(Reviewtestresultview.routeName, extra: result);
      }
    }
    return Material(
      color: tokens.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: openReview,
        mouseCursor: SystemMouseCursors.click,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: tokens.cardDecoration(theme),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Flexible(
                    child: Text(LocaleKeys.resultsCode(result.serialNumber),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: style.regular12.copyWith(color: tokens.muted))),
                const Spacer(),
                Text('${ResultsDateFormatter.number(context, percent)}%',
                    style: style.bold24.copyWith(
                        color: status.color,
                        fontFeatures: const [FontFeature.tabularFigures()])),
              ]),
              const SizedBox(height: 6),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: style.semiBold16
                            .copyWith(color: theme.colorScheme.onSurface))),
                if (captionConsistent) ...[
                  const SizedBox(width: 8),
                  Flexible(
                      child: Text(status.label,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              style.regular12.copyWith(color: status.color))),
                ],
              ]),
              const SizedBox(height: 14),
              AssessmentStatsRow(
                  earned: earned,
                  totalQuestions: result.totalQuestions,
                  attemptDate: result.joinedDate),
              const SizedBox(height: 14),
              AssessmentProgressBar(
                  progress: percent / 100, color: status.color),
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  AssessmentPassIndicator(isPassed: result.isPassed),
                  TonalViewResultButton(onPressed: openReview),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
