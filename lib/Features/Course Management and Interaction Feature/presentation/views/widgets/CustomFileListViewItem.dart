import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomUnAvilableSectionWidget.dart';

class Customfilelistviewitem extends StatelessWidget {
  const Customfilelistviewitem(
      {super.key,
      required this.item,
      required this.section,
      required this.isAvilabe,
      required this.course});
  final CourseFileEntity item;
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
                  item: Coursefileviewnavigationsrequirmentsentity(
                    file: item,
                    sectionId: section.id,
                    course: course,
                  ),
                  course: course)
              : null,
          child: Customcontainersectionitem(
            child: Customlisttilewidget(
              title: " ${item.title} ",
              image: item.preffixImage,
              subtitle: " (${item.description})",
            ),
          ),
        ),
        CustomUnAvailableSectionWidget(
          isAvailable: isAvilabe,
        )
      ],
    );
  }
}
