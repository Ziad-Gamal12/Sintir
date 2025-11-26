import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseBottomSheetCourseDetailsIsSubscribedBanner extends StatelessWidget {
  const CourseBottomSheetCourseDetailsIsSubscribedBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(LocaleKeys.subscribed,
          style:
              AppTextStyles(context).regular14.copyWith(color: Colors.white)),
    );
  }
}
