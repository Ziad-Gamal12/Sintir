import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_date_formatter.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';

class AssessmentScoreRing extends StatelessWidget {
  const AssessmentScoreRing({
    super.key,
    required this.percent,
    required this.color,
  });
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = ResultsTokens.of(Theme.of(context));
    final style = AppTextStyles(context);
    return SizedBox.square(
      dimension: 56,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: percent / 100,
            strokeWidth: 5,
            strokeCap: StrokeCap.round,
            backgroundColor: tokens.track,
            valueColor: AlwaysStoppedAnimation(color),
          ),
          Center(
            child: Text(
              '${ResultsDateFormatter.number(context, percent)}%',
              style: style.regular12.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
