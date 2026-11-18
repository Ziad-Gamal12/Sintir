import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberTrendPill extends StatelessWidget {
  const SubscriberTrendPill({super.key, required this.summary});
  final SubscriberPerformanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final delta = summary.trendDelta;
    if (delta == null) return const SizedBox.shrink();
    final tokens = ResultsTokens.of(Theme.of(context));
    final color = delta >= 1
        ? tokens.success
        : delta <= -1
        ? tokens.failure
        : tokens.muted;
    final icon = delta >= 1
        ? Icons.trending_up_rounded
        : delta <= -1
        ? Icons.trending_down_rounded
        : Icons.trending_flat_rounded;
    final label = delta >= 1
        ? LocaleKeys.subscriberTrendImprovingFor(
            delta.abs(),
            Localizations.localeOf(context).toString(),
          )
        : delta <= -1
        ? LocaleKeys.subscriberTrendDecliningFor(
            delta.abs(),
            Localizations.localeOf(context).toString(),
          )
        : LocaleKeys.subscriberTrendStable;
    return Semantics(
      label: LocaleKeys.subscriberTrendSemantics(label),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: tokens.border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context).regular11.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
