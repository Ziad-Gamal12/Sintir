import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomUnAvilableSectionWidget.dart';

class Customtestlistviewitem extends StatelessWidget {
  const Customtestlistviewitem({
    super.key,
    required this.item,
    required this.section,
    required this.isAvilabe,
    required this.course,
  });
  final CourseTestEntity item;
  final CourseSectionEntity section;
  final bool isAvilabe;
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Customcontainersectionitem(
            child: Customlisttilewidget(
                title: " ${item.title} ",
                image: item.preffixImage,
                subtitle: " (${item.durationTime} دقائق)",
                trailing: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      width: 90,
                      child: Custombutton(
                        text: "بدأ الأمتحان",
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () => isAvilabe
                            ? item.ontap(
                                context: context,
                                item:
                                    CourseExamViewNavigationsRequirmentsEntity(
                                        test: item,
                                        sectionId: section.id,
                                        course: course),
                                course: course)
                            : null,
                        child: const Icon(
                          Icons.key,
                          color: Colors.white,
                          size: 20,
                        ),
                      )),
                ))),
        CustomUnAvailableSectionWidget(isAvailable: isAvilabe),
      ],
    );
  }
}
