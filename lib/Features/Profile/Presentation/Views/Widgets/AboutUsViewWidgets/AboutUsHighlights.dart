import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsHighlightTile.dart';
import 'package:sintir/locale_keys.dart';

class AboutUsHighlights extends StatelessWidget {
  const AboutUsHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        _row(
          AboutUsHighlightTile(
            icon: Icons.menu_book_rounded,
            label: LocaleKeys.aboutUsHighlightCourses,
            color: scheme.primary,
          ),
          AboutUsHighlightTile(
            icon: Icons.timer_rounded,
            label: LocaleKeys.aboutUsHighlightExams,
            color: scheme.secondary,
          ),
        ),
        const SizedBox(height: 12),
        _row(
          AboutUsHighlightTile(
            icon: Icons.insights_rounded,
            label: LocaleKeys.aboutUsHighlightProgress,
            color: scheme.secondary,
          ),
          AboutUsHighlightTile(
            icon: Icons.school_rounded,
            label: LocaleKeys.aboutUsHighlightTeachers,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _row(Widget a, Widget b) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: a),
          const SizedBox(width: 12),
          Expanded(child: b),
        ],
      ),
    );
  }
}
