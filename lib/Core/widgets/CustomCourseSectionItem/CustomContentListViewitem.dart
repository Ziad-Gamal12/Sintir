import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseSectionItem/ContentContainer.dart';
import 'package:sintir/Core/widgets/CustomCourseSectionItem/SectionExpanded.dart';
import 'package:sintir/Core/widgets/CustomCourseSectionItem/SectionHeader.dart';

class CustomContentListViewitem extends StatefulWidget {
  const CustomContentListViewitem({
    super.key,
    required this.sectionItem,
    required this.course,
  });

  final CourseSectionEntity sectionItem;
  final CourseEntity course;

  @override
  State<CustomContentListViewitem> createState() =>
      _CustomContentListViewitemState();
}

class _CustomContentListViewitemState extends State<CustomContentListViewitem> {
  List<dynamic> sectionLessons = [];
  late ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _controller,
      child: BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
        listener: (context, state) {
          if (state is GetSectionItemsSuccess &&
              state.sectionId == widget.sectionItem.id) {
            setState(() {
              sectionLessons = state.items;
            });
          } else if (state is GetSectionItemsFailure) {
            ShowSnackBar(
              context: context,
              child: Text(
                state.errMessage,
                style: AppTextStyles(context)
                    .regular14
                    .copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) => ContentContainer(
          child: ExpandablePanel(
            controller: _controller,
            theme: const ExpandableThemeData(hasIcon: false),
            header: SectionHeader(
              sectionItem: widget.sectionItem,
              course: widget.course,
              controller: _controller,
              sectionLessons: sectionLessons,
            ),
            collapsed: const SizedBox(),
            expanded: SectionExpanded(
              sectionItem: widget.sectionItem,
              sectionLessons: sectionLessons,
            ),
          ),
        ),
      ),
    );
  }
}
