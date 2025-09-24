import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewSectionItemBottomSheetChild.dart';

class CustomAddNewCourseSectionItemButton extends StatelessWidget {
  const CustomAddNewCourseSectionItemButton({
    super.key,
    required this.courseId,
    required this.section,
  });
  final String courseId;
  final CourseSectionEntity section;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "أَضافة عنصر جديد",
        color: Colors.white,
        textColor: Colors.black,
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: Colors.black),
        onPressed: () {
          showCustomBottomSheet(
              context: context,
              child: IntrinsicHeight(
                child: CustomAddNewSectionItemBottomSheetChild(
                    section: section, courseId: courseId),
              ),
              scaffoldKey: Variables.courseDeatilsViewScaffoldKey);
        });
  }
}
