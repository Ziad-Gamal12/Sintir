import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomUnAvilableSectionWidget.dart';

class CustomVedioListViewItem extends StatelessWidget {
  const CustomVedioListViewItem(
      {super.key,
      required this.item,
      required this.course,
      required this.section,
      required this.isAvilabe});
  final CourseVideoItemEntity item;
  final CourseSectionEntity section;
  final bool isAvilabe;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isAvilabe
          ? item.ontap(
              context: context,
              requires: CourseVideoViewNavigationsRequirmentsEntity(
                  sectionId: section.id, courseEntity: course, video: item),
              course: course)
          : null,
      child: Stack(
        children: [
          Customcontainersectionitem(
              child: Customlisttilewidget(
            title: item.title,
            image: item.preffixImage,
            trailing: Text(
              "${item.durationTime} دقائق",
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.black),
            ),
          )),
          CustomUnAvailableSectionWidget(isAvailable: isAvilabe)
        ],
      ),
    );
  }
}
