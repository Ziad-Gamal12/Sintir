// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

/// Copy shown on the brand side of the split auth layout.
class AuthBrandContent {
  const AuthBrandContent({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

/// The coloured panel at the start side of the split (expanded) auth layout.
class AuthBrandPanel extends StatelessWidget {
  const AuthBrandPanel({
    super.key,
    required this.content,
    required this.onBack,
    this.illustration,
  });

  final AuthBrandContent content;
  final VoidCallback onBack;
  final String? illustration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dark mode: a deep brand-tinted navy instead of the saturated blue, so the
    // panel doesn't glare next to the dark form pane (≈ #1F2A4C on #121212).
    final panelColor = isDark
        ? Color.alphaBlend(
            KMainColor.withValues(alpha: .28),
            theme.scaffoldBackgroundColor,
          )
        : KMainColor;

    // The SVG illustrations are drawn for a light background, so their frame
    // stays light in both themes (a dark card made them look muddy).
    final illustrationFrame = isDark ? const Color(0xFFE6EBF8) : Colors.white;

    return ColoredBox(
      color: panelColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: .16),
                      fixedSize: const Size(44, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    'Sintir',
                    textDirection: TextDirection.ltr,
                    style: styles.bold24.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (illustration != null) ...[
                          Container(
                            constraints: const BoxConstraints(maxHeight: 280),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: illustrationFrame,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: SvgPicture.asset(
                              illustration!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                        Text(
                          content.title,
                          style: styles.bold30.copyWith(
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          content.description,
                          style: styles.regular16.copyWith(
                            color: Colors.white,
                            height: 1.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
