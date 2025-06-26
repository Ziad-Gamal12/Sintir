import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentOptions.dart';

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
          Variables.CourseDeatilsViewScaffoldKey.currentState!
              .showBottomSheet((context) {
            return IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.white),
                child: AddCourseSectionContentOptions(
                  optionRequirementsEntity: Optionnavigationrequirementsentity(
                      isNewSection: false,
                      section: section,
                      courseID: courseId),
                ),
              ),
            );
          });
        });
  }
}
