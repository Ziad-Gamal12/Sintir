import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/locale_keys.dart';

class CheckoutIncludesSection extends StatelessWidget {
  const CheckoutIncludesSection({super.key, required this.course});

  final CourseEntity course;

  List<_IncludeItem> _items(String locale) => [
        if (course.lessonsCount > 0)
          _IncludeItem(
            icon: Icons.play_circle_outline_rounded,
            label: LocaleKeys.lessonsLabel,
            value: LocaleKeys.courseLessonsCount(course.lessonsCount, locale),
          ),
        if (course.testsCount > 0)
          _IncludeItem(
            icon: Icons.fact_check_outlined,
            label: LocaleKeys.testsLabel,
            value: LocaleKeys.courseTestsCount(course.testsCount, locale),
          ),
        if (course.level.trim().isNotEmpty)
          _IncludeItem(
            icon: Icons.school_outlined,
            label: LocaleKeys.courseLevelLabel,
            value: LocaleKeys.courseLevelName(course.level),
          ),
        if (course.language.trim().isNotEmpty)
          _IncludeItem(
            icon: Icons.translate_rounded,
            label: LocaleKeys.teachingLanguageLabel,
            value: LocaleKeys.courseLanguageName(course.language),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final items = _items(locale);
    if (items.isEmpty) return const SizedBox.shrink();

    final rows = <Widget>[];
    for (var index = 0; index < items.length; index += 2) {
      if (index > 0) rows.add(const SizedBox(height: 8));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _IncludeTile(item: items[index])),
              const SizedBox(width: 8),
              Expanded(
                child: index + 1 < items.length
                    ? _IncludeTile(item: items[index + 1])
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      key: const ValueKey('checkout-includes'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.courseIncludes,
          style: AppTextStyles(context).bold16.copyWith(
            color: CourseCardMetrics.textColor(context),
          ),
        ),
        const SizedBox(height: 10),
        ...rows,
      ],
    );
  }
}

class _IncludeItem {
  const _IncludeItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _IncludeTile extends StatelessWidget {
  const _IncludeTile({required this.item});

  final _IncludeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CourseCardMetrics.surfaceColor(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CourseCardMetrics.borderColor(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: CourseCardMetrics.iconBackground(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.icon,
              size: 20,
              color: CourseCardMetrics.accentColor(context),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.label,
                  style: AppTextStyles(context).regular12.copyWith(
                    color: CourseCardMetrics.mutedColor(context),
                  ),
                ),
                Text(
                  item.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context).bold14.copyWith(
                    color: CourseCardMetrics.textColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
