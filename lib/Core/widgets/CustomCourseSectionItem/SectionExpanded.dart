import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListView.dart';
import 'package:sintir/constant.dart';

class SectionExpanded extends StatelessWidget {
  const SectionExpanded({
    super.key,
    required this.sectionItem,
    required this.sectionLessons,
  });

  final CourseSectionEntity sectionItem;
  final List<dynamic> sectionLessons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: state is GetSectionItemsLoading &&
                  state.sectionId == sectionItem.id
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
      },
    );
  }
}
