import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/InfoRow.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/SendCourseReportView.dart';
import 'package:sintir/constant.dart';

class CustomCourseIntroductionViewBodyHeader extends StatelessWidget {
  const CustomCourseIntroductionViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "تم انشاء بواسطة  ,",
                      style: AppTextStyles.regular10
                          .copyWith(color: Colors.black)),
                  TextSpan(
                      text: "Creatives X Event",
                      style: AppTextStyles.semiBold10
                          .copyWith(color: KSecondaryColor))
                ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "تاريخ اللنشر  ( 1/2/2023)",
                  style: AppTextStyles.regular10
                      .copyWith(color: const Color(0xff818181)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const InfoRow(
                  icon: Icons.language,
                  label: "العربية",
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: ")",
                    style: AppTextStyles.regular10
                        .copyWith(color: const Color(0xff818181)),
                  ),
                  TextSpan(
                      text: "220",
                      style: AppTextStyles.semiBold10
                          .copyWith(color: KSecondaryColor)),
                  TextSpan(
                      text: " طالب/ طالبه)",
                      style: AppTextStyles.regular10
                          .copyWith(color: const Color(0xff818181)))
                ])),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(Sendcoursereportview.routeName);
                  },
                  child: const InfoRow(
                    icon: Icons.report,
                    label: "تقديم ابلاغ",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const InfoRow(
                  icon: Icons.feedback,
                  label: "أراء طلاب أخرين",
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
