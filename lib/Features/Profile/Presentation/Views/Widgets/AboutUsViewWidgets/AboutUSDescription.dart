import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsCard.dart';
import 'package:sintir/locale_keys.dart';

class AboutUSDescription extends StatelessWidget {
  const AboutUSDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = AppTextStyles(context).semiBold14;
    final baseSize = base.fontSize ?? 14;

    final paragraphs = LocaleKeys.aboutUsDescription
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    final hasLead = paragraphs.length > 1;

    final lead = base.copyWith(
      fontSize: baseSize + 3,
      height: 1.6,
      fontWeight: FontWeight.w700,
      color: scheme.onSurface,
    );
    final body = base.copyWith(
      fontSize: baseSize + 2,
      height: 1.8,
      fontWeight: FontWeight.w500,
      color: scheme.onSurface.withValues(alpha: 0.72),
    );

    return AboutUsCard(
      padding: const EdgeInsets.all(22),
      child: Stack(children: [
        PositionedDirectional(
          top: 0,
          bottom: 0,
          start: 0,
          child: Container(
            width: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  scheme.primary,
                  Color.lerp(scheme.primary, Colors.white, 0.35)!,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < paragraphs.length; i++) ...[
                if (i > 0) const SizedBox(height: 16),
                Text(
                  paragraphs[i],
                  textAlign: TextAlign.start,
                  style: (i == 0 && hasLead) ? lead : body,
                ),
              ],
            ],
          ),
        ),
      ]),
    );
  }
}
