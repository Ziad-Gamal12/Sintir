import 'package:flutter/material.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/assessment_stat_item.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_date_formatter.dart';
import 'package:sintir/locale_keys.dart';

class AssessmentStatsRow extends StatelessWidget {
  const AssessmentStatsRow(
      {super.key,
      required this.earned,
      required this.totalQuestions,
      required this.attemptDate});
  final int earned;
  final int totalQuestions;
  final DateTime attemptDate;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: AssessmentStatItem(
                  icon: Icons.track_changes_rounded,
                  label: LocaleKeys.resultsEarnedScore,
                  value: LocaleKeys.resultsQuestionValue(earned, totalQuestions,
                      Localizations.localeOf(context).toString()))),
          const SizedBox(width: 12),
          Expanded(
              child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AssessmentStatItem(
              icon: Icons.calendar_month_rounded,
              label: LocaleKeys.resultsAttemptDate,
              value: ResultsDateFormatter.format(context, attemptDate),
            ),
          )),
        ],
      );
}
