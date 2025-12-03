import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomUnAvilableSectionWidget.dart';
import 'package:sintir/locale_keys.dart';

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
        InkWell(
          onTap: () => isAvilabe
              ? item.ontap(
                  context: context,
                  item: CourseExamViewNavigationsRequirmentsEntity(
                      test: item, sectionId: section.id, course: course),
                  course: course)
              : null,
          child: Customcontainersectionitem(
              child: Customlisttilewidget(
            title: " ${item.title} ",
            image: item.preffixImage,
            subtitle: " (${item.durationTime} ${LocaleKeys.durationMinutes})",
            trailing: Text(
              "${item.questions.length} ${LocaleKeys.questionsCount}",
              style: AppTextStyles(context).regular14,
            ),
          )),
        ),
        CustomUnAvailableSectionWidget(isAvailable: isAvilabe),
      ],
    );
  }
}
