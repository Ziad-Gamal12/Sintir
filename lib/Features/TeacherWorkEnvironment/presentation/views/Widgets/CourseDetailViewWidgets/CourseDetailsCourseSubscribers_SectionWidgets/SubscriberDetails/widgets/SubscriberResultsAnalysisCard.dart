import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsAnalysisCard extends StatelessWidget {
  const SubscriberResultsAnalysisCard({super.key, required this.summary});
  final SubscriberPerformanceSummary? summary;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final theme = Theme.of(context);
          final tokens = ResultsTokens.of(theme);
          final scale = MediaQuery.textScalerOf(context).scale(1);
          final height = 88 * scale.clamp(1.0, 1.5).toDouble();
          final gap = 10.0;
          final width = (constraints.maxWidth - gap * 2) / 3;
          final hasData = summary != null && summary!.percentages.isNotEmpty;
          final locale = Localizations.localeOf(context).toString();
          return Row(children: [
            _Stat(
                label: LocaleKeys.subscriberHighestResult,
                width: width,
                height: height,
                value: hasData ? _score(summary!.highest, locale) : '—',
                color: tokens.success),
            SizedBox(width: gap),
            _Stat(
                label: LocaleKeys.subscriberAverage,
                width: width,
                height: height,
                value: hasData
                    ? '${LocaleFormatter.number(summary!.average.round(), locale)}%'
                    : '—',
                color: tokens.primary,
                highlighted: true),
            SizedBox(width: gap),
            _Stat(
                label: LocaleKeys.subscriberLowestResult,
                width: width,
                height: height,
                value: hasData ? _score(summary!.lowest, locale) : '—',
                color: tokens.warning),
          ]);
        },
      );

  String _score(TestResultEntity? result, String locale) {
    if (result == null || result.totalQuestions <= 0) return '—';
    final correct =
        result.questionsSolvedListEntity.where((q) => q.isCorrect).length;
    return '${LocaleFormatter.number(correct, locale)} / ${LocaleFormatter.number(result.totalQuestions, locale)}';
  }
}

class _Stat extends StatelessWidget {
  const _Stat(
      {required this.label,
      required this.value,
      required this.width,
      required this.height,
      required this.color,
      this.highlighted = false});
  final String label, value;
  final double width, height;
  final Color color;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    return Semantics(
        label: '$label $value',
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            color: highlighted
                ? tokens.primary.withValues(alpha: .08)
                : tokens.inner,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: highlighted
                    ? tokens.primary.withValues(alpha: .5)
                    : tokens.border,
                width: highlighted ? 1.5 : 1),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .regular11
                    .copyWith(color: tokens.muted)),
            const SizedBox(height: 6),
            Directionality(
                textDirection: TextDirection.ltr,
                child: Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(context).bold20.copyWith(
                        color: color,
                        fontFeatures: const [FontFeature.tabularFigures()]))),
          ]),
        ));
  }
}
