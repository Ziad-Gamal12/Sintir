import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetails_EditeCoureInfoWidget.dart';

class CustomCourseDetailsBodyCourseInfoHeader extends StatelessWidget {
  const CustomCourseDetailsBodyCourseInfoHeader({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            child: Text(
              courseEntity.title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showCustomBottomSheet(
              scaffoldKey: Variables.courseDeatilsViewScaffoldKey,
              child: IntrinsicHeight(
                child: EditCourseInfoSection(course: courseEntity),
              ),
              context: context,
            );
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
