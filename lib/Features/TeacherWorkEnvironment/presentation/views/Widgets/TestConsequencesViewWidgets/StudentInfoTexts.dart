import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({super.key, required this.testResult});
  final TestResultEntity testResult;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final joined = testResult.joinedDate;
    final joinedDate =
        DateFormat.yMd(Localizations.localeOf(context).languageCode)
            .format(joined);
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          testResult.joinedbyentity.name,
          style: style.semiBold20,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            text: '${LocaleKeys.studentNumber} ',
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Text(
                    testResult.joinedbyentity.uid,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.regular12.copyWith(color: muted),
                  ),
                ),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style.regular12.copyWith(color: muted),
        ),
        const SizedBox(height: 4),
        Text(
          "${LocaleKeys.joinedDate}: $joinedDate",
          overflow: TextOverflow.ellipsis,
          style: style.regular12.copyWith(color: muted),
        ),
      ],
    );
  }
}
