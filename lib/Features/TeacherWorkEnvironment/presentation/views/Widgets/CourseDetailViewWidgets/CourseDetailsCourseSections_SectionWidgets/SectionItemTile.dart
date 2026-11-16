import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/DeleteMenuButton.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/locale_keys.dart';

class SectionItemTile extends StatelessWidget {
  const SectionItemTile({
    super.key,
    required this.course,
    required this.section,
    required this.itemId,
    required this.title,
    required this.image,
    required this.teacherId,
    this.subtitle,
    this.isTest = false,
    this.onTap,
  });
  final CourseEntity course;
  final CourseSectionEntity section;
  final bool isTest;
  final String itemId, title, image, teacherId;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = title.trim();
    return BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
      selector: (state) =>
          state is DeleteSectionItemLoading && state.sectionItemId == itemId,
      builder: (context, isDeleting) => CustomContainerSectionItem(
        onTap: isDeleting ? null : onTap,
        child: Customlisttilewidget(
          title: name,
          subtitle: subtitle,
          image: image,
          trailing: DeleteMenuButton(
            confirmTitle: LocaleKeys.deleteItemTitle,
            itemName: name,
            isLoading: isDeleting,
            onConfirmed: () =>
                context.read<CourseSectionsCubit>().deleteSectionItem(
                  courseId: course.id,
                  sectionId: section.id,
                  sectionItemId: itemId,
                  teacherId: teacherId,
                  isTest: isTest,
                ),
          ),
        ),
      ),
    );
  }
}
