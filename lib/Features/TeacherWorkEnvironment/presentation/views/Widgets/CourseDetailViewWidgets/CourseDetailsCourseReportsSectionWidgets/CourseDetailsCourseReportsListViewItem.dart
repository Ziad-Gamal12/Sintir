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
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300)),
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
                          .copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          " ${report.date.day} / ${report.date.month} / ${report.date.year}",
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: Colors.grey),
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
                          .copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: " ${report.type}",
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: Colors.black),
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
                              .copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: " ${report.description}",
                          style: AppTextStyles(context)
                              .regular14
                              .copyWith(color: Colors.red.shade700),
                        ),
                      ])),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Image.asset(Assets.assetsIconsWarning)
          ],
        ));
  }
}
