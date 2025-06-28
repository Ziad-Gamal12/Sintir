import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomFileListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomTestListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomVedioListViewItem.dart';

class CustomSectionListView extends StatefulWidget {
  const CustomSectionListView({
    super.key,
    required this.section,
  });
  final CourseSectionEntity section;

  @override
  State<CustomSectionListView> createState() => _CustomSectionListViewState();
}

class _CustomSectionListViewState extends State<CustomSectionListView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CourseSectionsCubit>(context).getSectionItems(
        sectionId: widget.section.id,
        courseId: context
            .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
            .course
            .id,
      );
    });
  }

  Widget getChild(dynamic item, BuildContext context) {
    bool isSubscribed = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .isSubscribed;
    CourseEntity course = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    if (item is Coursevedioitementity) {
      return CustomVedioListViewItem(
        course: course,
        isAvilabe: context
            .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
            .isSubscribed,
        item: item,
        section: widget.section,
      );
    } else if (item is Coursetestentity) {
      return Customtestlistviewitem(
        course: course,
        item: item,
        section: widget.section,
        isAvilabe: context
            .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
            .isSubscribed,
      );
    } else {
      return Customfilelistviewitem(
          section: widget.section,
          item: item,
          course: course,
          isAvilabe: isSubscribed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is GetSectionItemsFailure) {
          ShowSnackBar(
              context: context,
              child: Text(state.errMessage,
                  style: AppTextStyles.regular14.copyWith(color: Colors.white)),
              backgroundColor: Colors.red);
        } else if (state is GetSectionItemsSuccess &&
            state.sectionId == widget.section.id) {
          items = state.items;
        }
      },
      builder: (context, state) {
        return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: getChild(items[index], context),
                );
              },
            );
          },
        );
      },
    );
  }
}
