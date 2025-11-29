import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewSectionItemBottomSheetChild.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddNewCourseSectionItemButton extends StatelessWidget {
  const CustomAddNewCourseSectionItemButton({
    super.key,
    required this.courseEntity,
    required this.section,
  });
  final CourseEntity courseEntity;
  final CourseSectionEntity section;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: LocaleKeys.addLecture,
        color: Colors.grey.shade50,
        textColor: Colors.black,
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
        onPressed: () {
          showCustomBottomSheet(
            context: context,
            child: IntrinsicHeight(
              child: CustomAddNewSectionItemBottomSheetChild(
                  section: section, courseEntity: courseEntity),
            ),
          );
        });
  }
}
