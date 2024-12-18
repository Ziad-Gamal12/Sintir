import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetCourseDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetHeader.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetBody extends StatelessWidget {
  const CourseBottomSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const CourseBottomSheetHeader(),
          const SizedBox(
            height: 10,
          ),
          const CourseBottomSheetCourseDetails(),
          const Spacer(),
          Custombutton(
              text: "أشترك الأن",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {
                GoRouter.of(context).push(CourseIntroductionView.routeName);
              })
        ],
      ),
    );
  }
}
