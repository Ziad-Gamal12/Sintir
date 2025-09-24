import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CourseInfoCardCourseDescription extends StatefulWidget {
  const CourseInfoCardCourseDescription({
    super.key,
  });

  @override
  State<CourseInfoCardCourseDescription> createState() =>
      _CourseInfoCardCourseDescriptionState();
}

class _CourseInfoCardCourseDescriptionState
    extends State<CourseInfoCardCourseDescription> {
  bool isEllipsis = true;
  @override
  Widget build(BuildContext context) {
    CourseEntity courseEntity = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              setState(() {
                isEllipsis = !isEllipsis;
              });
            },
            child: Text(
              isEllipsis ? "عرض المزيد" : "عرض أقل",
              textAlign: TextAlign.left,
              style: AppTextStyles.semiBold10.copyWith(color: KMainColor),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          courseEntity.description,
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
          textAlign: TextAlign.start,
          maxLines: isEllipsis ? 2 : null,
          overflow: isEllipsis ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}
