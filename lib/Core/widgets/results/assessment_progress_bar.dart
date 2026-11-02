import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';

class AssessmentProgressBar extends StatelessWidget {
  const AssessmentProgressBar(
      {super.key, required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = ResultsTokens.of(Theme.of(context));
    return LayoutBuilder(
        builder: (context, constraints) => TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress.clamp(0, 1)),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, _) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 4,
                  child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        ColoredBox(
                            color: tokens.track,
                            child: const SizedBox.expand()),
                        SizedBox(
                          width: constraints.maxWidth * value,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              color,
                              Color.lerp(color, tokens.primary, .2)!,
                            ]),
                          )),
                        ),
                      ]),
                ),
              ),
            ));
  }
}
