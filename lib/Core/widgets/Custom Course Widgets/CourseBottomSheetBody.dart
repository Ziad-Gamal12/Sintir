import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetCourseDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetUnSubscribedActionButtons.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';

class CourseBottomSheetBody extends StatelessWidget {
  const CourseBottomSheetBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Bottomsheetnavigationrequirmentsentity
        bottomsheetnavigationrequirmentsentity =
        context.read<Bottomsheetnavigationrequirmentsentity>();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const CourseBottomSheetHeader(),
          const SizedBox(
            height: 10,
          ),
          const CourseBottomSheetCourseDetails(),
          const SizedBox(height: 50),
          context.read<Bottomsheetnavigationrequirmentsentity>().isSubscribed ==
                  false
              ? CourseBottomSheetUnSubscribedActionButtons(
                  bottomsheetnavigationrequirmentsentity:
                      bottomsheetnavigationrequirmentsentity)
              : Custombutton(
                  text: "الدخول للكورس",
                  color: Colors.white,
                  textColor: Colors.black,
                  side: const BorderSide(width: 1, color: Colors.black),
                  onPressed: () {
                    GoRouter.of(context).push(CourseIntroductionView.routeName,
                        extra: bottomsheetnavigationrequirmentsentity);
                  }),
        ],
      ),
    );
  }
}
