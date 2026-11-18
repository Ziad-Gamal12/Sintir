import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_date_formatter.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsCountTile extends StatelessWidget {
  const ResultsCountTile({
    super.key,
    required this.count,
    required this.tokens,
  });
  final int count;
  final ResultsTokens tokens;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    return Container(
      width: 80,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 9,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: tokens.inner,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ResultsDateFormatter.number(context, count),
            style: style.bold24.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            LocaleKeys.resultsRecordedCountValue(
              count,
              Localizations.localeOf(context).languageCode,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: style.regular11.copyWith(color: tokens.muted),
          ),
        ],
      ),
    );
  }
}
