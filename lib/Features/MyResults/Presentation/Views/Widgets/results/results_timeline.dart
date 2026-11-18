import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/assessment_result_card.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_timeline_entry.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';

class ResultsTimeline extends StatelessWidget {
  const ResultsTimeline({
    super.key,
    required this.results,
    required this.horizontalPadding,
    this.onViewResult,
  });
  final List<TestResultEntity> results;
  final double horizontalPadding;
  final ValueChanged<TestResultEntity>? onViewResult;

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: horizontalPadding),
    sliver: SliverList.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        final theme = Theme.of(context);
        final tokens = ResultsTokens.of(theme);
        return CustomPaint(
          key: ValueKey(item.serialNumber),
          painter: _RailPainter(
            theme.colorScheme.primary,
            tokens.track,
            tokens.timelineNode,
            index == 0,
            index == results.length - 1,
            Directionality.of(context),
          ),
          child: ResultsTimelineEntry(
            index: index,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 14),
              child: Row(
                children: [
                  const SizedBox(width: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AssessmentResultCard(
                      key: ValueKey('result-${item.serialNumber}'),
                      result: item,
                      onViewResult: onViewResult == null
                          ? null
                          : () => onViewResult!(item),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

class _RailPainter extends CustomPainter {
  const _RailPainter(
    this.primary,
    this.line,
    this.inactive,
    this.active,
    this.last,
    this.direction,
  );
  final Color primary, line, inactive;
  final bool active, last;
  final TextDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final x = direction == TextDirection.rtl ? size.width - 14 : 14.0;
    final node = active ? primary : inactive;
    final connector = Paint()
      ..color = line
      ..strokeWidth = 2;
    if (!active) canvas.drawLine(Offset(x, 0), Offset(x, 2), connector);
    if (!last) {
      canvas.drawLine(Offset(x, 26), Offset(x, size.height), connector);
    }
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = active ? primary : line;
    if (active) {
      ring
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
        ..color = primary.withValues(alpha: .35);
      canvas.drawCircle(Offset(x, 14), 12, ring);
      ring
        ..style = PaintingStyle.stroke
        ..maskFilter = null
        ..color = primary;
    }
    canvas.drawCircle(Offset(x, 14), 12, ring);
    canvas.drawCircle(Offset(x, 14), 4, Paint()..color = node);
  }

  @override
  bool shouldRepaint(covariant _RailPainter old) =>
      old.primary != primary ||
      old.line != line ||
      old.inactive != inactive ||
      old.active != active ||
      old.last != last ||
      old.direction != direction;
}
