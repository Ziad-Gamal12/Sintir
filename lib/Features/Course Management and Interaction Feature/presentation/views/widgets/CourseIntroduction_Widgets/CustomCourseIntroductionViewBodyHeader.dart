import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/InfoRow.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFedBackView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/SendCourseReportView.dart';
import 'package:sintir/constant.dart';

class CustomCourseIntroductionViewBodyHeader extends StatelessWidget {
  const CustomCourseIntroductionViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity =
        context.read<DisplayCourseBottomsheetNavigationRequirmentsEntity>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "تم انشاء بواسطة  ,",
                    style:
                        AppTextStyles.regular10.copyWith(color: Colors.black)),
                TextSpan(
                    text: requirmentsEntity.course.contentcreaterentity?.name,
                    style: AppTextStyles.semiBold10
                        .copyWith(color: KSecondaryColor))
              ])),
              const SizedBox(
                height: 10,
              ),
              Text(
                "تاريخ اللنشر(${requirmentsEntity.course.postedDate})",
                style: AppTextStyles.regular10
                    .copyWith(color: const Color(0xff818181)),
              ),
              const SizedBox(
                height: 10,
              ),
              InfoRow(
                icon: Icons.language,
                label: requirmentsEntity.course.language,
              ),
            ],
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Sendcoursereportview.routeName);
                },
                child: const InfoRow(
                  icon: FontAwesomeIcons.circleExclamation,
                  label: "تقديم ابلاغ",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Coursefedbackview.routeName,
                      extra: requirmentsEntity);
                },
                child: const InfoRow(
                  icon: FontAwesomeIcons.comment,
                  label: "أراء طلاب أخرين",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
