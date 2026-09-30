import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseReportsSummaryEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

import 'ReportStatCard.dart';
import 'utils/report_status_ui.dart';

class ReportsSummaryStrip extends StatelessWidget {
  const ReportsSummaryStrip({
    super.key,
    required this.summary,
    required this.includeDismissed,
    required this.wrap,
    this.horizontalCards,
  });

  final CourseReportsSummaryEntity summary;
  final bool includeDismissed, wrap;

  final bool? horizontalCards;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final horizontal = horizontalCards ?? includeDismissed;

    final cards = <Widget>[
      ReportStatCard(
        title: LocaleKeys.reportTotal,
        caption: LocaleKeys.reportSummaryTotalCaption,
        count: summary.total,
        color: scheme.onSurface,
        icon: Icons.inbox_outlined,
        horizontal: horizontal,
      ),
      ReportStatCard(
        title: LocaleKeys.reportOpen,
        caption: LocaleKeys.reportSummaryOpenCaption,
        count: summary.open,
        color: scheme.secondary,
        icon: Icons.pending_actions,
        highlighted: summary.open > 0,
        horizontal: horizontal,
      ),
      ReportStatCard(
        title: LocaleKeys.reportResolved,
        caption: LocaleKeys.reportSummaryResolvedCaption,
        count: summary.resolved,
        color: ReportStatus.resolved.color(context),
        icon: Icons.check_circle_outline,
        horizontal: horizontal,
      ),
      if (includeDismissed)
        ReportStatCard(
          title: LocaleKeys.reportDismissed,
          caption: LocaleKeys.reportSummaryDismissedCaption,
          count: summary.dismissed,
          color: scheme.onSurfaceVariant,
          icon: Icons.highlight_off,
          horizontal: horizontal,
        ),
    ];

    if (wrap) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final card in cards)
              SizedBox(width: horizontal ? 220 : 170, child: card),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      // Equal heights even if one caption wraps to two lines.
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < cards.length; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      end: i == cards.length - 1 ? 0 : 8),
                  child: cards[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
