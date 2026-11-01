import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_date_formatter.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_tokens.dart';

class ResultsAverageGauge extends StatelessWidget {
  const ResultsAverageGauge(
      {super.key, required this.value, required this.color});
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final diameter = 88.0;
    return Semantics(
      label: LocaleKeys.resultsGaugeSemantics(
          ResultsDateFormatter.number(context, value)),
      child: RepaintBoundary(
        child: SizedBox.square(
          dimension: diameter,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value.clamp(0, 100) / 100),
            duration: const Duration(milliseconds: 600),
            builder: (context, progress, _) => CustomPaint(
              painter: _GaugePainter(progress, theme.colorScheme.primary, color,
                  ResultsTokens.of(theme).track),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${ResultsDateFormatter.number(context, value)}%',
                          maxLines: 1,
                          style: style.bold20.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontFeatures: const [
                                FontFeature.tabularFigures()
                              ])),
                      Text(LocaleKeys.resultsAverage,
                          maxLines: 1,
                          style: style.regular11
                              .copyWith(color: ResultsTokens.of(theme).muted)),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter(this.progress, this.primary, this.accent, this.track);
  final double progress;
  final Color primary, accent, track;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 8.0;
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final sweep = math.pi * 2 * progress;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = track);
    final shader = LinearGradient(colors: [primary, accent]).createShader(rect);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, paint..shader = shader);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.progress != progress ||
      old.primary != primary ||
      old.accent != accent ||
      old.track != track;
}
