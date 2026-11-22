// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthParts.dart';
import 'package:svg_flutter/svg.dart';

class AuthBrandContent {
  const AuthBrandContent({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

class AuthBrandPanel extends StatelessWidget {
  const AuthBrandPanel({
    super.key,
    this.content,
    this.illustration,
    this.stage,
  });

  final AuthBrandContent? content;
  final String? illustration;
  final Widget? stage;

  static const double _minStageHeight = 560;

  static double widthFor(double maxWidth) => (maxWidth * 0.36)
      .clamp(math.min(400.0, maxWidth * 0.42), 560.0)
      .toDouble();

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);
    final styles = AppTextStyles(context);

    final stageChild = stage ??
        (illustration != null
            ? SvgPicture.asset(illustration!, fit: BoxFit.contain)
            : null);

    final copy = content == null
        ? null
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content!.title,
                style: styles.bold24.copyWith(
                  color: palette.onBrand,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                content!.description,
                style: styles.regular14.copyWith(
                  color: palette.onBrandMuted,
                  height: 1.8,
                ),
              ),
            ],
          );

    final wordmark = Align(
      alignment: AlignmentDirectional.centerStart,
      child: SintirWordmark(color: palette.onBrand),
    );

    return ColoredBox(
      color: palette.brandPanel,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 32, 40, 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight < _minStageHeight) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wordmark,
                      if (stageChild != null) ...[
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 180,
                          child: AuthIllustrationStage(
                            padding: const EdgeInsets.all(20),
                            child: stageChild,
                          ),
                        ),
                      ],
                      if (copy != null) ...[
                        const SizedBox(height: 24),
                        copy,
                      ],
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  wordmark,
                  const SizedBox(height: 32),
                  if (stageChild != null)
                    Expanded(child: AuthIllustrationStage(child: stageChild))
                  else
                    const Spacer(),
                  if (copy != null) ...[
                    const SizedBox(height: 32),
                    copy,
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
