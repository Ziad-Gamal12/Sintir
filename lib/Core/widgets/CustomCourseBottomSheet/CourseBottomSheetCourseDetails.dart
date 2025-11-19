// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetCourseDetailsDescription.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetCourseDetailsIsSubscribedBanner.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetCourseDetailsPrice.dart';

class CourseBottomSheetCourseDetails extends StatefulWidget {
  const CourseBottomSheetCourseDetails({
    super.key,
  });

  @override
  State<CourseBottomSheetCourseDetails> createState() =>
      _CourseBottomSheetCourseDetailsState();
}

class _CourseBottomSheetCourseDetailsState
    extends State<CourseBottomSheetCourseDetails>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    CourseEntity course = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    bool isSubscribed = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .isSubscribed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(course.title,
                    style: AppTextStyles(context).semiBold20)),
            Visibility(
              visible: isSubscribed,
              child: const CourseBottomSheetCourseDetailsIsSubscribedBanner(),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CourseBottomSheetCourseDetailsDescription(
            description: course.description),
        const SizedBox(
          height: 20,
        ),
        CourseBottomSheetCourseDetailsPrice(
            price: course.price, isSubscribed: isSubscribed),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
