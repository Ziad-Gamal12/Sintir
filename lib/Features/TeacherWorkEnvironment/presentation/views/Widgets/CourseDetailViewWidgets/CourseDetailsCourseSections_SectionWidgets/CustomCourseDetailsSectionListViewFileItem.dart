import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomTrashIcon.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/FileConsequencesView.dart';

class CustomCourseDetailsSectionListViewFileItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewFileItem(
      {super.key,
      required this.item,
      required this.section,
      required this.course});
  final CourseFileEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          FileConsequencesView.routeName,
          extra: item,
        );
      },
      child: Customcontainersectionitem(
          child: Customlisttilewidget(
              title: " ${item.title} ",
              image: item.preffixImage,
              subtitle: " (${item.description})",
              trailing: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomTrashIcon(onpressed: () {})))),
    );
  }
}
