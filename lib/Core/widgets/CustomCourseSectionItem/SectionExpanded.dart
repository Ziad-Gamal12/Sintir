import 'package:flutter/material.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListView.dart';
import 'package:sintir/constant.dart';

class SectionExpanded extends StatelessWidget {
  const SectionExpanded({
    super.key,
    required this.sectionItem,
    required this.sectionLessons,
    required this.state,
  });

  final CourseSectionEntity sectionItem;
  final List<dynamic> sectionLessons;
  final CourseSectionsState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: state is GetSectionItemsLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: KMainColor,
              ),
            )
          : CustomSectionListView(
              section: sectionItem,
              items: sectionLessons,
            ),
    );
  }
}
