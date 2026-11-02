import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';

class ResultsLoading extends StatelessWidget {
  const ResultsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    final style = AppTextStyles(context);
    Widget card(Widget child) => DecoratedBox(
        decoration: tokens.cardDecoration(theme),
        child: Padding(
            padding: const EdgeInsetsDirectional.all(16), child: child));
    return Center(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Skeletonizer(
          enabled: true,
          containersColor: tokens.inner,
          effect: ShimmerEffect(
              baseColor: tokens.inner,
              highlightColor:
                  Color.lerp(tokens.inner, theme.colorScheme.primary, .12)!),
          child: ExcludeSemantics(
            child: ListView(
                padding: const EdgeInsetsDirectional.all(16),
                children: [
                  card(Row(children: [
                    const CircleAvatar(radius: 28),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Student name', style: style.semiBold16),
                          Text('12/08/2025', style: style.regular12),
                        ])),
                  ])),
                  const SizedBox(height: 16),
                  card(Row(children: [
                    const CircleAvatar(radius: 44),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('General average', style: style.semiBold16),
                          Text('Recorded assessments', style: style.regular12),
                        ])),
                    const CircleAvatar(radius: 30),
                  ])),
                  const SizedBox(height: 20),
                  for (var index = 0; index < 2; index++) ...[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            const CircleAvatar(radius: 12),
                            if (index == 0)
                              Container(
                                  width: 2, height: 180, color: tokens.track),
                          ]),
                          const SizedBox(width: 8),
                          Expanded(
                              child: card(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('Assessment title',
                                    style: style.semiBold16),
                                Text('Earned points', style: style.regular12),
                                const SizedBox(height: 48),
                                Text('Attempt date', style: style.regular12),
                              ]))),
                        ]),
                    const SizedBox(height: 14),
                  ],
                ]),
          )),
    ));
  }
}
