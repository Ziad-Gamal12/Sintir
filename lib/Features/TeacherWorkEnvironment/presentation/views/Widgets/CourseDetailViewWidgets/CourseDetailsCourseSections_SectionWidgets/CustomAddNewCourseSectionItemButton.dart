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
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final Color buttonColor = theme.cardColor; // Background
    final Color textColor = theme.textTheme.bodyLarge!.color!; // Text

    final Color borderColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    return Custombutton(
        text: LocaleKeys.addLecture,
        color: buttonColor,
        textColor: textColor,
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
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
