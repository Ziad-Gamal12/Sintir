import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_chart_data.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsChart extends StatelessWidget {
  const SubscriberResultsChart({super.key, required this.summary});
  final SubscriberPerformanceSummary summary;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final theme = Theme.of(context);
          final tokens = ResultsTokens.of(theme);
          final styles = AppTextStyles(context);
          final locale = Localizations.localeOf(context).toString();
          final all = summary.percentages;
          final values = all.length > 6 ? all.sublist(all.length - 6) : all;
          final width =
              constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;
          final height = (width * .55).clamp(200.0, 280.0).toDouble();
          final delta = summary.trendDelta;
          final trend = delta == null || delta.abs() < 1
              ? LocaleKeys.subscriberTrendStable
              : delta > 0
                  ? LocaleKeys.subscriberTrendImprovingFor(delta, locale)
                  : LocaleKeys.subscriberTrendDecliningFor(delta.abs(), locale);
          return Semantics(
            label: LocaleKeys.subscriberChartSemantics(
              all.length,
              all.isEmpty ? 0 : all.first,
              all.isEmpty ? 0 : all.last,
              trend,
              locale,
            ),
            child: Container(
              padding: const EdgeInsetsDirectional.all(16),
              decoration: tokens.cardDecoration(theme),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.examScoreProgression,
                        style: styles.semiBold14
                            .copyWith(color: theme.colorScheme.onSurface)),
                    if (values.length < 2) ...[
                      const SizedBox(height: 8),
                      Text(LocaleKeys.subscriberChartNeedsTwo,
                          style:
                              styles.regular12.copyWith(color: tokens.muted)),
                    ],
                    const SizedBox(height: 8),
                    SizedBox(
                      height: height,
                      child: values.isEmpty
                          ? Center(
                              child: Text(LocaleKeys.noResults,
                                  style: styles.regular12
                                      .copyWith(color: tokens.muted)))
                          : RepaintBoundary(
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: LineChart(SubscriberChartData.build(
                                  context: context,
                                  values: values,
                                  totalCount: all.length,
                                  tokens: tokens,
                                  styles: styles,
                                  locale: locale,
                                )),
                              ),
                            ),
                    ),
                  ]),
            ),
          );
        },
      );
}
