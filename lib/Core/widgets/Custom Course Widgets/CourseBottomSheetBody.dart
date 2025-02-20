import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetCourseDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseBottomSheetHeader.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetBody extends StatelessWidget {
  const CourseBottomSheetBody({
    super.key,
    required this.course,
  });
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          CourseBottomSheetHeader(
            courseContentCreater: course.contentcreaterentity!,
          ),
          const SizedBox(
            height: 10,
          ),
          CourseBottomSheetCourseDetails(
            course: course,
          ),
          const SizedBox(height: 50),
          Custombutton(
              text: "استكشاف المحتوى",
              color: Colors.white,
              textColor: Colors.black,
              side: const BorderSide(width: 1, color: Colors.black),
              onPressed: () {
                GoRouter.of(context)
                    .push(CourseIntroductionView.routeName, extra: course);
              }),
          const SizedBox(
            height: 10,
          ),
          Custombutton(
              text: "أشترك الأن",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {})
        ],
      ),
    );
  }
}
