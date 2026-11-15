// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';

class CourseItemTitleBlock extends StatelessWidget {
  const CourseItemTitleBlock({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleStyle = styles.semiBold12.copyWith(
      color: isDark ? Colors.white : Colors.black,
    );
    final descStyle = styles.regular12.copyWith(
      color: isDark ? Colors.white60 : Colors.grey.shade600,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(
            text: title,
            style: CourseCardMetrics.resolve(context, titleStyle),
          ),
          textDirection: Directionality.of(context),
          textScaler: CourseCardMetrics.textScaler(context),
          locale: Localizations.maybeLocaleOf(context),
          maxLines: 1,
        )..layout(maxWidth: constraints.maxWidth);
        final isSingleLine = !painter.didExceedMaxLines;
        painter.dispose();

        final showDescription = isSingleLine && description.trim().isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: showDescription ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
            if (showDescription)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: descStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}
