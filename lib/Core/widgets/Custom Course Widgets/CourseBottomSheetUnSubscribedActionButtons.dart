import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetUnSubscribedActionButtons extends StatelessWidget {
  const CourseBottomSheetUnSubscribedActionButtons({
    super.key,
    required this.bottomsheetnavigationrequirmentsentity,
  });

  final Bottomsheetnavigationrequirmentsentity
      bottomsheetnavigationrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Custombutton(
            text: "استكشاف المحتوى",
            color: Colors.white,
            textColor: Colors.black,
            side: const BorderSide(width: 1, color: Colors.black),
            onPressed: () {
              GoRouter.of(context).push(CourseIntroductionView.routeName,
                  extra: bottomsheetnavigationrequirmentsentity);
            }),
        const SizedBox(
          height: 10,
        ),
        Custombutton(
            text: "أشترك الأن",
            color: KSecondaryColor,
            textColor: Colors.white,
            onPressed: () {}),
      ],
    );
  }
}
