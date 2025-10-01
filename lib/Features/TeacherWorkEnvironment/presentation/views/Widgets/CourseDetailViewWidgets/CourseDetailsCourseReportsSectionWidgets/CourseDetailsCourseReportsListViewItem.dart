import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class CourseDetailsCourseReportsListViewItem extends StatelessWidget {
  const CourseDetailsCourseReportsListViewItem(
      {super.key, required this.report});
  final CourseReportEntity report;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffF2F2F7),
            borderRadius: BorderRadius.circular(8)),
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
                      text: "ابلاغ منذ:",
                      style: AppTextStyles(context)
                          .semiBold16
                          .copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: " ${report.date}",
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
                      text: "النوع:",
                      style: AppTextStyles(context)
                          .regular14
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
                          text: "المحتوى:",
                          style: AppTextStyles(context)
                              .regular16
                              .copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: " ${report.description}",
                          style: AppTextStyles(context)
                              .regular14
                              .copyWith(color: Colors.black),
                        ),
                      ])),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Image.asset(Assets.assetsImagesWarning)
          ],
        ));
  }
}
