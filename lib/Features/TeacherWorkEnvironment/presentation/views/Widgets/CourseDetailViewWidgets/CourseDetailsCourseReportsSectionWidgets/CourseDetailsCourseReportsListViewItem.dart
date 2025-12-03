import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsCourseReportsListViewItem extends StatelessWidget {
  const CourseDetailsCourseReportsListViewItem(
      {super.key, required this.report});
  final CourseReportEntity report;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardBackgroundColor = theme.cardColor; // Use theme card color
    final Color borderColor = theme.dividerColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodySmall!.color!;
    final Color descriptionColor = theme.colorScheme.error.withOpacity(0.8);

    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "${LocaleKeys.createdDate}:",
                      style: AppTextStyles(context)
                          .semiBold16
                          .copyWith(color: primaryTextColor),
                    ),
                    TextSpan(
                      text:
                          " ${report.date.day} / ${report.date.month} / ${report.date.year}",
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: secondaryTextColor),
                    ),
                  ])),
                  const SizedBox(
                    height: 5,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "${LocaleKeys.report}:",
                      style: AppTextStyles(context)
                          .bold14
                          .copyWith(color: primaryTextColor),
                    ),
                    TextSpan(
                      text: " ${report.type}",
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: primaryTextColor),
                    ),
                  ])),
                  const SizedBox(
                    height: 5,
                  ),
                  Text.rich(
                      overflow: TextOverflow.ellipsis,
                      TextSpan(children: [
                        TextSpan(
                          text: " ${LocaleKeys.descriptionLabel}:",
                          style: AppTextStyles(context)
                              .bold14
                              .copyWith(color: primaryTextColor),
                        ),
                        TextSpan(
                          text: " ${report.description}",
                          style: AppTextStyles(context)
                              .regular14
                              .copyWith(color: descriptionColor),
                        ),
                      ])),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(child: Image.asset(Assets.assetsIconsWarning))
          ],
        ));
  }
}
