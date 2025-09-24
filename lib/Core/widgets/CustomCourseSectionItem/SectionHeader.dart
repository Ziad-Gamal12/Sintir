import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.sectionItem,
    required this.course,
    required this.controller,
    required this.sectionLessons,
  });

  final CourseSectionEntity sectionItem;
  final CourseEntity course;
  final ExpandableController controller;
  final List<dynamic> sectionLessons;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (sectionLessons.isEmpty) {
          BlocProvider.of<CourseSectionsCubit>(context).getSectionItems(
            sectionId: sectionItem.id,
            courseId: course.id,
          );
        }
        controller.toggle();
      },
      child: Customlisttilewidget(
        title: sectionItem.title,
        image: Assets.assetsImagesSectionIcon,
        subtitle: sectionItem.subtitle,
      ),
    );
  }
}
